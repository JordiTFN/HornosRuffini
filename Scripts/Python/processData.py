import pandas as pd

pathToRawFile = "../../Data/Raw_Data/DatosHornos.txt"
pathToProcessedFile = "../../Data/Processed_Data/Processed_Data.txt"
pathToRegistersFile = "../../Data/Processed_Data/Resgisters.txt"
rawDataFile = open(pathToRawFile, 'r')
processedDataFile = open(pathToProcessedFile, 'w+')
registersDataFile = open(pathToRegistersFile, 'w+')

registersDataFile.write("[registro];0;id;codigo;nombre;fecha;turno;tipo;cantidad;kgs;;;;;;;;;;;EOL;")
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


registersDataFrame = pd.read_csv(pathToRegistersFile, sep=';', usecols=['id', 'codigo', 'fecha', 'turno', 'tipo', 'cantidad', 'kgs'])
registersDates = registersDataFrame.fecha.unique()
registersTurns = registersDataFrame.turno.unique()

for fecha in registersDates:
    for turno in registersTurns:
        print("---> " + fecha + " / " + str(turno))
        print(registersDataFrame[registersDataFrame.fecha == fecha][registersDataFrame.turno == turno])