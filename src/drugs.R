# read raw files, downloaded from ""
# on sep 29 2022
#dr <- read.delim("~/Downloads/allfiles/drug.txt", sep = ",", header = FALSE, colClasses = rep("character", 14))
#ingred <- read.delim("~/Downloads/allfiles/ingred.txt", sep = ",", header = FALSE, colClasses = rep("character", 15))
#form <- read.delim("~/Downloads/allfiles/form.txt", sep = ",", header = FALSE, colClasses = rep("character", 4))

# Reduce to needed columns only
ingredR <- ingred[,c(1,3,5,6,8,10)]
formR <- form[, c(1,3)]
drR <- dr[, c(1,5,6)]

# merge
mm <- merge(x = ingredR, y = drR, by = "V1")
m3 <- merge(x = mm, y = formR, by = "V1")

# concatenate fields into one product name to make a list
drugs <- c()
for (i in 1:length(m3$V1)) {
    my_row <- m3[i,]
    gg <- grep(paste0("^", my_row$V1, "$"), m3$V1)
    if (length(gg) > 1) {
        my_row$V3.x <- paste0(m3[gg,]$V3.x, collapse = "/")
        my_row$V5.x <- paste0(m3[gg,]$V5.x, collapse = "/")
        my_row$V6.x <- paste0(m3[gg,]$V6.x, collapse = "/")
    }
    if (my_row$V8 != "") {
        my_drug <- paste0(my_row$V3.x, " ", my_row$V5.x, my_row$V6.x, "/", my_row$V8, my_row$V10, "--", my_row$V5.y, " ", my_row$V6.y, " ", my_row$V3.y)
        drugs <- c(drugs, my_drug)
    } else {
        my_drug <- paste0(my_row$V3.x, " ", my_row$V5.x, my_row$V6.x, " ", my_row$V8, my_row$V10, "--", my_row$V5.y, " ",  my_row$V6.y, " ", my_row$V3.y)
        drugs <- c(drugs, my_drug)
    }
}

# save file
save(drugs, file = "drugs.Rds")

