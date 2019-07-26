function insertRegistro(conexionDB, parsedLine)
    string = "INSERT INTO Registros VALUES(";
    string = strcat(string, parsedLine{3});
    string = strcat(string, ", '");
    string = strcat(string, parsedLine{4});
    string = strcat(string, "', '");
    string = strcat(string, parsedLine{5});
    string = strcat(string, "', STR_TO_DATE('");
    string = strcat(string, parsedLine{6});
    string = strcat(string, "','%d.%m.%Y'), ");
    string = strcat(string, parsedLine{7});
    string = strcat(string, ", '");
    string = strcat(string, parsedLine{8});
    string = strcat(string, "', ");
    string = strcat(string, parsedLine{9});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{10});
    string = strcat(string, ")");
    exec(conexionDB, string);
end