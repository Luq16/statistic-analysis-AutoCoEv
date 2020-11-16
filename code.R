#install and load necessary packages
#if packages already installed and loaded, skip.
#But if packages installed and not loaded then load
#If packages not installed. Install and load.
packages = c("readxl", "openxlsx")

## Now load or install&load all
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)


#filePath<-""# first define the path of the csv file



AdjustedPval<-function(filePath){
    # function calculates Adjusted P values. It calculates bonferroni, BH,
    # holm, hochberge, hommel and BY and add new columns to the original csv file
    # Inpute: File path, the location of the csv file. Assuming P value is 
    #         in a column named Best.P.value.
  
  data<-read_excel(filePath)# read file
  sortedData =data[order(data$Best.P.value),]# order by P-Value
  sortedData$Bonferroni=p.adjust(sortedData$Best.P.value,method = "bonferroni")
  sortedData$BH =p.adjust(sortedData$Best.P.value,method = "BH")
  sortedData$Holm =p.adjust(sortedData$Best.P.value,method = "holm")
  sortedData$Hochberg =p.adjust(sortedData$Best.P.value,method = "hochberg")
  sortedData$Hommel =p.adjust(sortedData$Best.P.value,method = "hommel")
  sortedData$BY =p.adjust(sortedData$Best.P.value,method = "BY")
  openxlsx::write.xlsx(sortedData,filePath)# update filePath by adding new columns of Adj. P-values
  #return(sortedData)
}
 
###############################################################################
#Example

filePath<-"C:/Users/luolaw/Desktop/AutoCoev/raftCoev/raftCoev.xlsx"
dataWithAdjPval<-AdjustedPval(filePath)