library(tidyverse)
library(ggplot2)
library(janitor)

march_2023 <- read.csv("~/Case Study/202303-divvy-tripdata.csv")
april_2023 <- read.csv("~/Case Study/202304-divvy-tripdata.csv")
may_2023 <- read.csv("~/Case Study/202305-divvy-tripdata.csv")
june_2023 <- read.csv("~/Case Study/202306-divvy-tripdata.csv")
july_2023 <- read.csv("~/Case Study/202307-divvy-tripdata.csv")
august_2023 <- read.csv("~/Case Study/202308-divvy-tripdata.csv")
september_2023 <- read.csv("~/Case Study/202309-divvy-tripdata.csv")
october_2023 <- read.csv("~/Case Study/202310-divvy-tripdata.csv")
november_2023 <- read.csv("~/Case Study/202311-divvy-tripdata.csv")
december_2023 <- read.csv("~/Case Study/202312-divvy-tripdata.csv")
january_2024 <- read.csv("~/Case Study/202401-divvy-tripdata.csv")
february_2024 <- read.csv("~/Case Study/202402-divvy-tripdata.csv")
march_2024 <- read.csv("~/Case Study/202403-divvy-tripdata.csv")

total_year <- rbind(march_2023,april_2023,may_2023,june_2023,july_2023,august_2023,september_2023,october_2023,november_2023,december_2023,january_2024,february_2024,march_2024)

write.csv(total_year,file="~/Case Study/total_year.csv")

names(total_year)
summary(total_year)
str(total_year)
View(head(total_year))
View(tail(total_year))

clean_total_year <- total_year[complete.cases(total_year),]

clean_total_year <- drop_na(clean_total_year)
clean_total_year <- remove_empty(clean_total_year)
clean_total_year <- remove_missing(clean_total_year)
clean_total_year <- distinct(clean_total_year)

clean_total_year$date <- as.Date(clean_total_year$started_at)
clean_total_year$week_day <- format(as.Date(clean_total_year$date), "%A")
clean_total_year$month <- format(as.Date(clean_total_year$date), "%b_%y")
clean_total_year$year <- format(clean_total_year$date, "%Y")
clean_total_year$time <- as.POSIXct(clean_total_year$started_at, format = "%Y-%m-%d %H:%M:%S")
clean_total_year$time <- format(clean_total_year$time, format = "%H:%M")

clean_total_year$ride_length <- difftime(clean_total_year$ended_at, clean_total_year$started_at, units = "mins")

clean_total_year <- clean_total_year %>%
  filter(started_at < ended_at)

clean_total_year <- clean_total_year[!clean_total_year$ride_length>1440,] 

clean_total_year <- clean_total_year[!clean_total_year$ride_length<5,] 

clean_total_year <- clean_total_year %>% 
  select(rideable_type, member_casual, month, year, time, started_at, ended_at, week_day, ride_length)

write.csv(clean_total_year,file = "~/Case Study/clean_total_year.csv")