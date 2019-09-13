import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

pathToProcessedRegisters = "../../Data/Processed_Data/Processed_Registers.txt"
daysToShow = 30*3

sns.set(style='white')
testDataFrame = pd.read_csv(pathToProcessedRegisters, sep=';').head(daysToShow)
plot1 = sns.barplot(data=testDataFrame, x='fecha', y='gas', hue='turno', ci=0, )
plot1.set(xlabel = "Fecha", ylabel = "Consuma de Gas")
plot1.set_xticklabels(labels=plot1.get_xticklabels(), rotation=45)

'''
plot2 = plot1.twinx()
plot2.plot(testDataFrame['limpieza'], hue='turno')
'''
sns.despine()
plt.show()