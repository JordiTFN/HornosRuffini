#---El puesto de Luis Franco en todas las echas registradas en orden ascendente---#
SELECT O.TURNO, O.Fecha,O.Ocupacion
FROM OCUPACIONES O, EMPLEADOS E 
WHERE O.IDEmpleado = E.ID AND E.Nombre="Luis Franco"
ORDER BY O.Fecha ASC;

#---El consumo total de gas para cada mes---#
SELECT YEAR(FECHA), MONTH(Fecha), SUM(Cantidad) FROM Registros
WHERE Tipo = 'GAS'
GROUP BY YEAR(FECHA), MONTH(Fecha);

#--El consumo de gas total para cada turno---#
SELECT Turno, SUM(Cantidad) FROM Registros
WHERE Tipo = "GAS"
GROUP BY Turno;

SELECT DISTINCT Tipo FROM Registros;

SELECT * FROM ALEACIONES;
SELECT * FROM BRIQUETAS;
SELECT * FROM CALENDARIO;
SELECT * FROM EMPLEADOS;
SELECT * FROM OCUPACIONES;
SELECT * FROM RECURSOS;
SELECT * FROM REGISTROS;