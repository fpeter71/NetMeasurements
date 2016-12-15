/*
DROP DATABASE IF EXISTS "net_measurementdb";
CREATE DATABASE "net_measurementdb"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE "net_measurementdb"
    IS 'neteera measurement database';
*/

-- clean up
DROP VIEW IF EXISTS setup_read;

DROP TABLE IF EXISTS sweep;
DROP TABLE IF EXISTS setup_definition;
DROP TABLE IF EXISTS amp_settings;

DROP TYPE IF EXISTS sweep_type;
DROP TYPE IF EXISTS powermeter_type;

-- type defs
CREATE TYPE sweep_type AS ENUM ('vgate', 'frequency', 'other', 'modulation');
CREATE TYPE powermeter_type AS ENUM ('notused', 'vdi', 'qmc', 'other');

-- tables
-- standard amplifier settings
CREATE TABLE amp_settings(
	id         	SERIAL PRIMARY KEY,
	name     	varchar(32),
	
    chopping_freq			integer NOT NULL DEFAULT 100000,

-- amp control
   	input_chopping			smallint NOT NULL DEFAULT 1,
	calibration_input_grounded	smallint NOT NULL DEFAULT 1,
	positive_grounded		smallint NOT NULL DEFAULT 0,
	negative_grounded		smallint NOT NULL DEFAULT 0,
	multiplication_5x_20x		smallint NOT NULL DEFAULT 1,
	multiplication_50x_100x		smallint NOT NULL DEFAULT 0,
	output_demodulation		smallint NOT NULL DEFAULT 1,
	output_polarity			smallint NOT NULL DEFAULT 0,
	bypass_lpf			smallint NOT NULL DEFAULT 1,
	enable_input_offset		smallint NOT NULL DEFAULT 1
);

CREATE TABLE setup_definition(
-- simple ids, date
	id          	SERIAL PRIMARY KEY,
	date   		timestamp DEFAULT current_timestamp,
	comment     	varchar(255),

-- hardware spec
	ant_generation      	integer NOT NULL DEFAULT 1,
	ant_serial		integer NOT NULL DEFAULT 1,
	amp_used		smallint NOT NULL DEFAULT 1,
	amp_generation		integer NOT NULL DEFAULT 1,
	amp_serial		integer NOT NULL DEFAULT 1,

-- amp setting
	amp_setting integer REFERENCES amp_settings (id),
    
-- others
	power_meter_type	powermeter_type DEFAULT 'vdi'	
);

CREATE TABLE sweep(
-- simple ids, date
	id          	SERIAL PRIMARY KEY,
	date_prod   	timestamp DEFAULT current_timestamp,
	comment     	varchar(255),
	temperature		double precision NOT NULL DEFAULT 25.0,

-- setup id
	setup	 integer REFERENCES setup_definition (id),

-- antenna/amp specification
	amp_channel	integer NOT NULL DEFAULT 0 CHECK (amp_channel >= 0 AND amp_channel <16),

-- constants values (overdriven if swept)
	vgate		double precision NOT NULL DEFAULT 0,
	frequency	double precision NOT NULL DEFAULT 0,
    modulation  double precision NOT NULL DEFAULT 0,

-- sweep type
	sweep		sweep_type DEFAULT 'vgate',

-- ranges
	sweep_start		double precision NOT NULL,
	sweep_end		double precision NOT NULL,
	sweep_step		double precision NOT NULL,

-- resuls and something (e.g. power meter read)
	response	double precision[],
	noise		double precision[],
	power		double precision[],

	aux_response	double precision[]
);

-- query views
CREATE VIEW setup_read AS SELECT sd.id,
    sd.date,
    sd.comment,
    sd.ant_generation,
    sd.ant_serial,
    sd.amp_used,
    sd.amp_generation,
    sd.amp_serial,
    amp.name,
    amp.chopping_freq,
    amp.input_chopping,
    amp.calibration_input_grounded,
    amp.positive_grounded,
    amp.negative_grounded,
    amp.multiplication_5x_20x,
    amp.multiplication_50x_100x,
    amp.output_demodulation,
    amp.output_polarity,
    amp.bypass_lpf,
    amp.enable_input_offset,
    sd.power_meter_type
   FROM setup_definition sd
     JOIN amp_settings amp ON sd.amp_setting = amp.id;   
    
