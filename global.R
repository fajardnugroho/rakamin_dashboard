

# Library

library(shiny)
library(shinyjs)
library(shinyauthr)
library(shinyWidgets)
library(shinydashboard)
library(plotly)
library(tidyverse)
library(httr)
library(jsonlite)
library(magrittr)
library(rjson)
library(zoo)
library(scales)
library(echarts4r)
library(highcharter)
library(htmlwidgets)

# option colour

# red, yellow, aqua, blue, light-blue, green, navy, teal, olive, lime, orange, fuchsia, purple, maroon, black.




# Data Input

## Data Transaction PBI
# pbi_free_vip <- GET("https://redash.rakamin.com/api/queries/648/results.json?api_key=ozwj8JhUMm17egMOpdn2WLd5eMLdOfkHiQVCFYrE")
#  
# pbi_free_vip_api_char <- base::rawToChar(pbi_free_vip$content)
#  
# pbi_free_vip_api_json <- jsonlite::fromJSON(pbi_free_vip_api_char, flatten = TRUE)
#  
# pbi_free_vip_df <- data.frame(pbi_free_vip_api_json$query_result$data$rows)



# Data Wrangling

## Cleaning

pbi_free_vip_df_clean <- pbi_free_vip_df |> 
  mutate(Category = as.factor(Category),
         End.Batch = ymd_hms(End.Batch),
         VIX.batch = my(VIX.batch),
         VIX.batch = as.yearmon(VIX.batch, "%b - %y"),
         status = as.factor(status),
         Paid = ymd_hms(Paid),
         Field = as.factor(Field),
         Access.Tier = as.factor(Access.Tier),
         Checkout = ymd_hms(Checkout),
         Start.Batch = ymd_hms(Start.Batch),
         Batch = as.yearmon(Start.Batch, "%b - %y"),
         title = as.factor(title),
         paid_amount = as.numeric(paid_amount),
         amount = as.numeric(amount),
         registration_starts_at = ymd_hms(registration_starts_at),
         registration_ends_at = ymd_hms(registration_ends_at),
         amount_category = ifelse(paid_amount > 0, "Rp not Null", "Rp Null"),
         amount_category = as.factor(amount_category),
         amount_alpha = ifelse(paid_amount > 0, 1, 0.5)
         # amount_category = as.factor(amount_category)
         
  ) |> 
  rename(Paid.Date = Paid) |> 
  rename(Checkout.Date = Checkout)

## Aggregate for Total Registrant PBI by Batch

pbi_total_registrant_by_batch <- pbi_free_vip_df_clean |>
  select(Batch, name, Access.Tier, amount_category, amount_alpha) |>
  group_by(Batch, Access.Tier, amount_category, amount_alpha) |>
  count(Batch) |>
  rename(Total.Registrant = n) |>
  mutate(Total.Registrant = as.numeric(Total.Registrant),
         # Batch = as.factor(Batch))
         Batch = my(Batch))
# Batch = yearmon(Batch))


sum_registrant <- pbi_total_registrant_by_batch |> 
  group_by(Batch) |>
  summarise(total = sum(Total.Registrant))

choise_df_rp <- data.frame(type = c("revenue", "user")) |>
  mutate(type = as.factor(type))


# revenue <- pbi_free_vip_df_clean |>
#   select(Batch, paid_amount) |>
#   summarise(paid_amount = sum(paid_amount), .by = Batch) |> 
#   ggplot(aes(x = Batch, y = paid_amount)) +
#   geom_col()


# user <- pbi_free_vip_df_clean |>
#   filter(Access.Tier != "free") |>
#   select(Batch, amount_category) |>
#   group_by(Batch, amount_category) |>
#   count(Batch) |>
#   rename(Total.Registrant = n) |>
#   mutate(Total.Registrant = as.numeric(Total.Registrant), #) |> 
#          Batch = my(Batch)) |> 
#   filter(Batch >= input$Range_Batch[1] & Batch <= input$Range_Batch[2]) |> 
#   ggplot(aes(x = Batch, y = n, fill = amount_category)) +
#   geom_col(position = "dodge") +
#   theme(axis.text.x=element_text(vjust = 1), legend.position = "none",
#         legend.title = element_text(inherit.blank = FALSE))



# glimpse(pbi_free_vip_df_clean)
# names(pbi_free_vip_df_clean)




# pbi_total_registrant_yearmon <- pbi_free_vip_df_clean |>
#   select(Batch, name) |>
#   group_by(Batch) |>
#   count(Batch) |>
#   ungroup(Batch) |> 
#   rename(Total.Registrant = n) |>
#   mutate(Total.Registrant = as.numeric(Total.Registrant),
#          # Batch = as.factor(Batch))
#          Batch = my(Batch))
#          # Batch = as.Date(Batch, "%M-%Y"))
# 
# pbi_total_registrant_yearmon$Batch <- format(as.Date(pbi_total_registrant_yearmon$Batch), "%Y-%m")



# Data Visualization











# Function


source(ui <- "ui.R")
source(server <- "server.R")
shinyApp(ui, server)

