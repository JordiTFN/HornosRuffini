function insertAleacion(conexionDB, parsedLine)
        string = "INSERT INTO Aleaciones VALUES(";
        string = strcat(string, parsedLine{3});
        string = strcat(string, ", '");
        string = strcat(string, parsedLine{4});
        string = strcat(string, "', '");
        string = strcat(string, parsedLine{5});
        string = strcat(string, "')");
        exec(conexionDB, string);
end