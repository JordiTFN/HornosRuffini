clear all;
close all;
path = 'DatosHornos.txt';
Size_Archivo=21;
formats='%s';
for w=1:Size_Archivo-1
formats = strcat(formats,'%s');
end
headerLines = 0;
delimiter = ';';
[M{1:Size_Archivo}] = textread(path, formats,'headerlines', headerLines, 'delimiter', delimiter);
[matriz_x,matriz_y] = size(M);
for i=1:matriz_y
[size_x,size_y] = size(M{1,i});

for j=1:size_x
    matriz{j,i}=M{1,i}{j,1};
end
end