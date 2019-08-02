disp("Ejecutando la transformacón del fichero de datos medinate Python...")
drawnow
tic
if system("python -W ignore ../Python/processData.py") == 0
    disp("Datos transformados correctamente.")
else
    disp("Error al ejecutar el script.")
end
toc
drawnow

disp("Creando tablas de la base de datos y leyendo el fichero de inicialización...")
drawnow
tic

conexionDB = database('hornosruffini', 'root', 'j25g01'); %Creamos la conexion con la base de datos

            %========== CREACIÓN TABLAS Y ELIMINACIÓN DE EXISTENTES ==========%           
exec(conexionDB, 'DROP TABLE IF EXISTS Calendario'); %Si la tabla ya existe la eliminamos
exec(conexionDB, 'DROP TABLE IF EXISTS Empleados'); %Si la tabla ya existe la eliminamos
exec(conexionDB, 'DROP TABLE IF EXISTS Ocupaciones'); %Si la tabla ya existe la eliminamos
exec(conexionDB, 'DROP TABLE IF EXISTS Aleaciones'); %Si la tabla ya existe la eliminamos
exec(conexionDB, 'DROP TABLE IF EXISTS Briquetas'); %Si la tabla ya existe la eliminamos
exec(conexionDB, 'DROP TABLE IF EXISTS Recursos'); %Si la tabla ya existe la eliminamos
exec(conexionDB, 'DROP TABLE IF EXISTS Registros'); %Si la tabla ya existe la eliminamos
exec(conexionDB, 'CREATE TABLE Calendario(Fecha DATE NOT NULL PRIMARY KEY)'); %Creamos la tabla de fechas
exec(conexionDB, 'CREATE TABLE Empleados(ID INT NOT NULL PRIMARY KEY, Codigo VARCHAR(50) NOT NULL, Nombre VARCHAR(100))'); %Creamos la tabla de empleados
exec(conexionDB, 'CREATE TABLE Ocupaciones(Fecha DATE NOT NULL, Turno INT NOT NULL, IDEmpleado INT NOT NULL, Ocupacion VARCHAR(20) NOT NULL, PRIMARY KEY(Fecha, Turno, IDEmpleado))'); %Creamos la tabla de Ocupaciones
exec(conexionDB, 'CREATE TABLE Aleaciones(ID INT NOT NULL PRIMARY KEY, Codigo VARCHAR(20) NOT NULL, Nombre VARCHAR(50) NOT NULL)');
exec(conexionDB, 'CREATE TABLE Briquetas(ID INT NOT NULL PRIMARY KEY, Codigo VARCHAR(20) NOT NULL, Nombre VARCHAR(50), Fe FLOAT, Si FLOAT, Cu FLOAT, Mn FLOAT, Mg FLOAT, Zn FLOAT, Sn FLOAT, Ti FLOAT, Cr FLOAT, Ni FLOAT, Pb FLOAT)');
exec(conexionDB, 'CREATE TABLE Recursos(ID INT NOT NULL PRIMARY KEY, Codigo VARCHAR(50) NOT NULL, Nombe VARCHAR(150))');
exec(conexionDB, 'CREATE TABLE Registros(Fecha DATE NOT NULL, Turno INT NOT NULL, Gas FLOAT, Limpieza FLOAT, TemChimenea FLOAT, TemBobeda FLOAT,	Escoria FLOAT, Inactividad FLOAT, NataHorno FLOAT, NataCuba FLOAT, NataMaquina FLOAT, Briqueta FLOAT, kgCuba FLOAT, kgLingote FLOAT, kgCajaColada FLOAT, CantidadCuba FLOAT, CantidadLingote FLOAT, CantidadCajaColada FLOAT, PRIMARY KEY(Fecha, Turno))');

fileId = fopen('../../Data/Processed_Data/Processed_Data.txt'); %Abrimos el archivo de datos
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
        case '[recurso]' %recurso, vamos a su funcion
            insertRecurso(conexionDB, parsedLine);
    end
    fileLine = fgetl(fileId); %Avanzamos a la siguiente linea
end
fclose(fileId); %Cerramos el archivo

fileId = fopen('../../Data/Processed_Data/Processed_Registers.txt');
fileLine = fgetl(fileId);
fileLine = fgetl(fileId);
while ischar(fileLine)
    parsedLine = strsplit(fileLine, ';');
    insertRegistro(conexionDB, parsedLine);
    fileLine = fgetl(fileId);
end
fclose(fileId);
toc
disp("Ejecución finalizada");
