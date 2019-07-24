function insertCalendario(conexionDB, parsedLine)
    if parsedLine{2} ~= '0'
        string = "INSERT INTO Calendario VALUES(STR_TO_DATE('"; %Concatenamos los diferentes Strings para
        string = strcat(string, parsedLine{3});                 %generar la consulta SQL que insertará una fecha
        string = strcat(string, "', '%d.%m.%Y'))");
        exec(conexionDB, string); %Ejecutamos la consulta sobre la base de datos
    end
end