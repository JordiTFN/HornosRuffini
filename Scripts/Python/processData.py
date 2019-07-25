pathToRawFile = "../../Data/Raw_Data/DatosHornos.txt"
pathToProcessedFile = "../../Data/Processed_Data/Processed_Data.txt"
rawDataFile = open(pathToRawFile, 'r')
processedDataFile = open(pathToProcessedFile, 'w+')

dateLines = []
for line in rawDataFile:
    doWrite = True
    parsedLine = line.split(';')

    if parsedLine[1] != '0':
        if parsedLine[0] == '[calendario]' and parsedLine[2] not in dateLines:
            dateLines.append(parsedLine[2])
        elif parsedLine[0] == '[calendario]' and parsedLine[2] in dateLines:
            doWrite = False

        if doWrite == True and ',' in line:
            line = line.replace(',', '.')

        if doWrite == True and ';;' in line:
            line = line.replace(';;', ";NULL;")
            line = line.replace(';;', ';')

        if doWrite == True and ' ' in line:
            line = line.replace(' ', '')

        processedDataFile.write(line) if doWrite else ()

rawDataFile.close()
processedDataFile.close()