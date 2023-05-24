#https://genviz.org/module-03-genvisr/0003/07/01/lohSpec_GenVisR/

Download the "HCC1395.varscan.tsv"  from http://genomedata.org/gen-viz-workshop/GenVisR/HCC1395.varscan.tsv 

# read in the varscan data
lohData <- read.delim("HCC1395.varscan.tsv", header=FALSE)

# grab only those columns which are required and name them
lohData <- lohData[,c("V1", "V2", "V7", "V11")]
colnames(lohData) <- c("chromosome", "position", "n_vaf", "t_vaf")

# add a sample column
lohData$sample <- "HCC1395"

# convert the normal and tumor vaf columns to fractions
lohData$n_vaf <- as.numeric(gsub("%", "", lohData$n_vaf))/100
lohData$t_vaf <- as.numeric(gsub("%", "", lohData$t_vaf))/100

# limit to just the genome of interest
lohData <- lohData[grepl("^\\d|X|Y", lohData$chromosome),]


# Create an inital plot
lohSpec(lohData, genome="hg19")


# Obtain variants with a VAF greater than 0.4 and below 0.6.
lohData <- lohData[lohData$n_vaf > 0.4 & lohData$n_vaf < 0.6,]

# run lohSpec
lohSpec(x=lohData)

