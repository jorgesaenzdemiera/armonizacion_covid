DROP SCHEMA IF EXISTS datoscovid;
CREATE SCHEMA datoscovid;
USE datoscovid;

CREATE TABLE datos_finales(
PATIENT_ID INT NOT NULL AUTO_INCREMENT,
DMRAGEYR VARCHAR(8) NOT NULL,
DMRGENDR VARCHAR(6) NOT NULL,
DATAD VARCHAR(15) NOT NULL,
DATLGTI VARCHAR(8) NOT NULL,
DATDSI VARCHAR(15) NOT NULL,
DSXOS VARCHAR(6) NOT NULL,
CSXBTPA VARCHAR(7) NOT NULL,
CSXCHRA VARCHAR(8) NOT NULL,
LBXSGLA VARCHAR(8) NOT NULL,
CSXOSTA VARCHAR(8) NOT NULL,
CSXSYA VARCHAR(8) NOT NULL,
CSXDIA VARCHAR(8) NOT NULL,
CSXCHRHn VARCHAR(8) NOT NULL,
CSXBTPHn VARCHAR(11) NOT NULL,
LBXSGLHn VARCHAR(8) NOT NULL,
CSXOSTHn VARCHAR(8) NOT NULL,
CSXSYHn VARCHAR(8) NOT NULL,
CSXDIHn VARCHAR(8) NOT NULL,
PRIMARY KEY (PATIENT_ID)
);

CREATE TABLE cargas(
ID_carga INT NOT NULL AUTO_INCREMENT,
fecha DATETIME NOT NULL,
nombre_archivo_procedente VARCHAR(100) NOT NULL,
PRIMARY KEY (ID_carga)
);

CREATE TABLE columnas_transformadas(
ID_columna_transformada INT NOT NULL AUTO_INCREMENT,
nombre_original VARCHAR(100) NOT NULL,
nombre_final VARCHAR(100) NOT NULL,
ID_carga INT NOT NULL,
PRIMARY KEY (ID_columna_transformada),
FOREIGN KEY (ID_carga) REFERENCES cargas (ID_carga)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE columnas_no_transformadas(
ID_columna_no_transformada INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(100),
ID_carga INT NOT NULL,
PRIMARY KEY (ID_columna_no_transformada),
FOREIGN KEY (ID_carga) REFERENCES cargas (ID_carga)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE datos_no_cargados(
ID_dato_no_cargado INT NOT NULL AUTO_INCREMENT,
valor VARCHAR(100) NOT NULL,
ID_columna_no_transformada INT NOT NULL,
PATIENT_ID INT,
PRIMARY KEY (ID_dato_no_cargado),
FOREIGN KEY (ID_columna_no_transformada) REFERENCES columnas_no_transformadas (ID_columna_no_transformada)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (PATIENT_ID) REFERENCES datos_finales (PATIENT_ID)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE nulos(
ID_nulo INT NOT NULL AUTO_INCREMENT,
dato_inicial VARCHAR(100) NOT NULL,
motivo VARCHAR(100) NOT NULL,
ID_columna_transformada INT,
PATIENT_ID INT NOT NULL,
PRIMARY KEY (ID_nulo),
FOREIGN KEY (ID_columna_transformada) REFERENCES columnas_transformadas (ID_columna_transformada)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (PATIENT_ID) REFERENCES datos_finales (PATIENT_ID)
ON DELETE CASCADE ON UPDATE CASCADE
);