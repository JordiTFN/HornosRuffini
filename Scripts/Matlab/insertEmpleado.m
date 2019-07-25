function insertEmpleado(conexionDB, parsedLine)
        string = "INSERT INTO Empleados VALUES("; %Concatenamos los diferentes Strings para general la consulta
        string = strcat(string, parsedLine{3});   %SQL que añadirá un empleado a la tabla
        string = strcat(string,", '");
        string = strcat(string, parsedLine{4});
        string = strcat(string, "', '");
        string = strcat(string, parsedLine{5});
        string = strcat(string, "')");
        exec(conexionDB, string); %Ejecutamos la consulta sobre la base de datos
end