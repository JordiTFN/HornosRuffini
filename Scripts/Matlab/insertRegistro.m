function insertRegistro(conexionDB, parsedLine)
    string = "INSERT INTO Registros VALUES(STR_TO_DATE('";
    string = strcat(string, parsedLine{1});
    string = strcat(string, "','%d.%m.%Y'), ");
    string = strcat(string, parsedLine{2});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{3});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{4});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{5});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{6});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{7});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{8});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{9});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{10});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{11});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{12});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{13});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{14});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{15});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{16});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{17});
    string = strcat(string, ", ");
    string = strcat(string, parsedLine{18});
    string = strcat(string, ")");
    %disp(string)
    exec(conexionDB, string);
end