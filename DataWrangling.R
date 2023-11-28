library(dplyr)
library(stringr)

acs_diversity <- read_csv("ACS Diversity 5-Year 2015-2019.csv")
youth_developmental <- read_csv("CopyOfChildren who have one or more emotional, behavioral, or developmental conditions (1).csv")

# new categorical variable
both_df <- merge(x = youth_developmental, y = acs_diversity, by.x = "Location", by.y = "...4", all.y = TRUE, all.x = TRUE)

#new numerical variable
# Convert the column to numeric
both_df$`30 to 39 Years Old` <- as.numeric(both_df$`30 to 39 Years Old`)
both_df$`40 to 49 Years Old` <- as.numeric(both_df$`40 to 49 Years Old`)

# Check if there are any non-numeric values in the columns for both data set
non_numeric_values <- which(!is.numeric(both_df$`30 to 39 Years Old`))
if (length(non_numeric_values) > 0) {
  cat("Non-numeric values found in '30 to 39 Years Old' column at positions:", non_numeric_values, "\n")
}

non_numeric_values <- which(!is.numeric(both_df$`40 to 49 Years Old`))
if (length(non_numeric_values) > 0) {
  cat("Non-numeric values found in '40 to 49 Years Old' column at positions:", non_numeric_values, "\n")
}

# Calculate the sum of two category (age 30 to 49)
total_30_39 <- sum(both_df$`30 to 39 Years Old`, na.rm = TRUE)
total_40_49 <- sum(both_df$`40 to 49 Years Old`,na.rm = TRUE)

age30_age49 <- total_30_39 + total_40_49

#Summarize
summarize_age30_age49 <- data.frame (
                                    
  age_30_39 <- both_df$`30 to 39 Years Old`,
  age_40_49 <- both_df$`40 to 49 Years Old`
    
)
print(summarize_age30_age49)
