disp("Comenzando la creaci�n de la base de datos y la subida de �stos...")
conexionDB = database('hornosruffini', 'root', 'j25g01'); %Creamos la conexion con la base de datos

            %========== CREACI�N TABLAS Y ELIMINACI�N DE EXISTENTES ==========%           
exec(conexionDB, 'DROP TABLE IF EXISTS Calendario'); %Si la tabla ya existe la eliminamos
exec(conexionDB, 'DROP TABLE IF EXISTS Empleados'); %Si la tabla ya existe la eliminamos
exec(conexionDB, 'DROP TABLE IF EXISTS Ocupaciones'); %Si la tabla ya existe la eliminamos
exec(conexionDB, 'DROP TABLE IF EXISTS Aleaciones'); %Si la tabla ya existe la eliminamos
exec(conexionDB, 'DROP TABLE IF EXISTS Briquetas'); %Si la tabla ya existe la eliminamos
exec(conexionDB, 'CREATE TABLE Calendario(Fecha DATE NOT NULL PRIMARY KEY)'); %Creamos la tabla de fechas
exec(conexionDB, 'CREATE TABLE Empleados(ID INT NOT NULL PRIMARY KEY, Codigo VARCHAR(50) NOT NULL, NombreCompleto VARCHAR(100))'); %Creamos la tabla de empleados
exec(conexionDB, 'CREATE TABLE Ocupaciones(Fecha DATE NOT NULL, Turno INT NOT NULL, IDEmpleado INT NOT NULL, Ocupacion VARCHAR(20) NOT NULL, PRIMARY KEY(Fecha, Turno, IDEmpleado))'); %Creamos la tabla de Ocupaciones
exec(conexionDB, 'CREATE TABLE Aleaciones(ID INT NOT NULL PRIMARY KEY, Codigo VARCHAR(20) NOT NULL, Nombre VARCHAR(50) NOT NULL)');
exec(conexionDB, 'CREATE TABLE Briquetas(ID INT NOT NULL PRIMARY KEY, Codigo VARCHAR(20) NOT NULL, Nombre VARCHAR(50), Fe FLOAT, Si FLOAT, Cu FLOAT, Mn FLOAT, Mg FLOAT, Zn FLOAT, Sn FLOAT, Ti FLOAT, Cr FLOAT, Ni FLOAT, Pb FLOAT)');
fileId = fopen('../Data/data.txt'); %Abrimos el archivo de datos
fileLine = fgetl(fileId); %Vamos a iterando de linea en linea

while ischar(fileLine) %Mientras tengamos datos en el archivo...
    parsedLine = strsplit(fileLine, ';'); %Lo partimos por los ';'
    switch parsedLine{1} %Si el primer campo es de tipo...
        case '[calendario]' %calendario, vamos a su funcion
            insertCalendario(conexionDB, parsedLine);
        case '[ocupacion]' %ocupacion, vamos a su funcion
            insertOcupacion(conexionDB, parsedLine);
        case '[empleado]' %empleado, vamos a su funcion
            insertEmpleado(conexionDB, parsedLine);
        case '[aleacion]' %aleacion, vamos a su funcion
            insertAleacion(conexionDB, parsedLine);
        case '[briqueta]' %briqueta, vamos a su funcion
            insertBriqueta(conexionDB, parsedLine);
    end
    fileLine = fgetl(fileId); %Avanzamos a la siguiente linea
end

fclose(fileId); %Cerramos el archivo
disp("Ejecuci�n finalizada");
