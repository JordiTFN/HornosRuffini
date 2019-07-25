function insertOcupacion(conexionDB, parsedLine)
        string = "INSERT INTO Ocupaciones VALUES(STR_TO_DATE('";
        string = strcat(string, parsedLine{3});
        string = strcat(string, "', '%d.%m.%Y'), ");
        string = strcat(string, parsedLine{4});
        string = strcat(string, ", ");
        string = strcat(string, parsedLine{6});
        string = strcat(string, ", '");
        string = strcat(string, parsedLine{5});
        string = strcat(string, "')");
        exec(conexionDB, string);
end