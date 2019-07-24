SELECT O.TURNO, O.Fecha,O.Ocupacion, E.NombreCompleto FROM OCUPACIONES O, EMPLEADOS E WHERE O.IDEmpleado = E.ID AND E.NombreCompleto="Luis Franco";

CREATE TABLE Aleaciones(ID INT NOT NULL PRIMARY KEY, Codigo VARCHAR(20) NOT NULL, Nombre VARCHAR(50) NOT NULL);
SELECT * FROM aleaciones;