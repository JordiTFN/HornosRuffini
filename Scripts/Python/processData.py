import pandas as pd
import os
import seaborn as sns
import matplotlib.pyplot as plt

pathToRawFile = "../../Data/Raw_Data/DatosHornos.txt"
pathToProcessedFile = "../../Data/Processed_Data/Processed_Data.txt"
pathToRegistersFile = "../../Data/Processed_Data/Resgisters.txt"
pathToProcessedRegisters = "../../Data/Processed_Data/Processed_Registers.txt"
rawDataFile = open(pathToRawFile, 'r')
processedDataFile = open(pathToProcessedFile, 'w+')
registersDataFile = open(pathToRegistersFile, 'w+')

registersDataFile.write("[registro];0;id;codigo;nombre;fecha;turno;tipo;cantidad;kgs;;;;;;;;;;;EOL;" + '\n')
dateLines = []
for line in rawDataFile:
    doWrite = True
    parsedLine = line.split(';')

    if parsedLine[1] != '0':
        if parsedLine[0] == '[calendario]' and parsedLine[2] not in dateLines:
            dateLines.append(parsedLine[2])
        elif parsedLine[0] == '[calendario]' and parsedLine[2] in dateLines:
            doWrite = False

        if parsedLine[3] == 'BORRAR':
            doWrite = False
        
        if doWrite == True and ',' in line:
            line = line.replace(',', '.')

        if doWrite == True and ';;' in line:
            line = line.replace(';;', ";NULL;")
            line = line.replace(';;', ';')

        if doWrite == True and (parsedLine[0] == '[ocupacion]' or parsedLine[0] == '[registro]') and ' ' in line:
            line = line.replace(' ', '')

        processedDataFile.write(line) if doWrite else ()
        registersDataFile.write(line) if doWrite and parsedLine[0] == '[registro]' else ()

rawDataFile.close()
processedDataFile.close()
registersDataFile.close()

#-------------------------------------------------⬆️⬆️⬆️NORMALIZACIÓN INICIAL DE DATOS⬆️⬆️⬆️-------------------------------------------------#
#===============================================================================================================================================#
#-------------------------------------------------⬇️⬇️⬇️CREACIÓN DE TABLA DE REGISTROS⬇️⬇️⬇️-------------------------------------------------#

processedRegistersFile = open(pathToProcessedRegisters, 'w+')
processedRegistersFile.write("fecha;turno;gas;limpieza;temChimenea;temBobeda;escoria;inactividad;natahorno;natacuba;natamaquina;briqueta;kgcuba;kglingote;kgcajacolada;cantidadcuba;cantidadlingote;cantidadcajacolada" + "\n")

registersDataFrame = pd.read_csv(pathToRegistersFile, sep=';', usecols=['id', 'codigo', 'fecha', 'turno', 'tipo', 'cantidad', 'kgs'])
registersDates = registersDataFrame.fecha.unique()
registersTurns = registersDataFrame.turno.unique()

for fecha in registersDates:
    for turno in registersTurns:
        sumaGas = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'GAS']['cantidad'].sum(axis=0)
        sumaLimpieza = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'LIMPIEZA']['cantidad'].sum(axis=0)
        temChimenea = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'TEMCHIMENEA']['cantidad'].sum(axis=0)
        temBobeda = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'TEMBOBEDA']['cantidad'].sum(axis=0)
        escoria = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'ESCORIA']['cantidad'].sum(axis=0)
        inactividad = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'INACTIVO']['cantidad'].sum(axis=0)
        nataHorno = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'NATAHORNO']['cantidad'].sum(axis=0)
        nataCuba = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'NATACUBA']['cantidad'].sum(axis=0)
        nataMaquina = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'NATAMAQUINA']['cantidad'].sum(axis=0)
        briqueta = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'BRIQUETA']['cantidad'].sum(axis=0)
        kgCuba = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'CUBA']['kgs'].sum(axis=0)
        cantidadCuba = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'CUBA']['cantidad'].sum(axis=0)
        kgLingote = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'LINGOTE']['kgs'].sum(axis=0)
        cantidadLingote = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'LINGOTE']['cantidad'].sum(axis=0)
        kgCajaColda = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'CAJACOLADA']['kgs'].sum(axis=0)
        cantidadCajaColada = registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno][registersDataFrame.tipo == 'CAJACOLADA']['cantidad'].sum(axis=0)


        processedRegistersFile.write(str(fecha) + ";"
        + str(turno) + ";" 
        + str(sumaGas) + ";" 
        + str(sumaLimpieza) + ";" 
        + str(temChimenea) + ";" 
        + str(temBobeda) + ";"
        + str(escoria) + ";"
        + str(inactividad) + ";"
        + str(nataHorno) + ";"
        + str(nataCuba) + ";"
        + str(nataMaquina) + ";"
        + str(briqueta) + ";"
        + str(kgCuba) + ";"
        + str(kgLingote) + ";" 
        + str(kgCajaColda) + ";"
        + str(cantidadCuba) + ";"
        + str(cantidadLingote) + ";"
        + str(cantidadCajaColada)
        + "\n")

processedRegistersFile.close()
os.remove(pathToRegistersFile)