


server <- function(input, output) {

    # set.seed(122)
    # histdata <- rnorm(500)
    # 
    # output$plot1 <- renderPlot({
    #   data <- histdata[seq_len(input$slider)]
    #   hist(data)
    # })
    
    # Range Date Input & Output
    
    output$selected_dates <- renderPrint({
      paste("Selected Date Range:", input$Range_Batch[1], "to", input$Range_Batch[2])
    })
    
    # Graph Total Registrant by Batch
    
    output$total_registrant_pbi_by_batch <- renderPlotly({
      
        
      
      data_pbi <- pbi_free_vip_df_clean |>
        select(Batch, name, Access.Tier) |>
        group_by(Batch, Access.Tier) |>
        count(Batch) |>
        # mutate(total = n) |> 
        # summarise(total = sum(total)) |> 
        # ungroup(Batch, Access.Tier) |> 
        rename(Total.Registrant = n) |>
        mutate(Total.Registrant = as.numeric(Total.Registrant), #) |> 
               Batch = my(Batch)) |> 
        filter(Batch >= input$Range_Batch[1] & Batch <= input$Range_Batch[2]) |> 
        # filter(paid_amount >= input$Range_Price[1] & paid_amount <= input$Range_Price[2]) |> 
        filter(Access.Tier %in% input$User)
        # filter(amount_category %in% input$Amount_Category) |> 
        
        
      sum_registrant <- data_pbi |> 
        group_by(Batch) |>
        summarise(total = sum(Total.Registrant))
      
      
        ggplot(data = data_pbi, aes(x = Batch, y = Total.Registrant, fill = Access.Tier)) + 
        geom_col(position = "dodge") + #, stat = "identity") + #, alpha = amount_alpha) + #position = "stack") +
        geom_text(aes(x = Batch, y = Total.Registrant, group = Access.Tier, label = Total.Registrant), position = position_dodge(width = 1), vjust = 100) +
        scale_color_brewer() +
        # scale_alpha_binned() +
        # geom_col(aes(fill = amount_category), position = "dodge") + #position = "stack") +
        theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1)) +
        theme(axis.text.x=element_text(vjust = 1), legend.position = "none",
              legend.title = element_text(inherit.blank = FALSE)) +
        labs( y ="Total Registrant", fill = "Total Registrant") +
      
        geom_text(data = sum_registrant, aes(x = Batch, y = total, label = total, fill = NULL), size = 4, color = "black", position = position_stack(1))
      
    })
    
    
    # Value box
    
    output$revenue_header<-renderValueBox({    
      
      
        revenue_header_sum_current <- pbi_free_vip_df_clean |>
          select(Batch, paid_amount) |>
          summarise(paid_amount = sum(paid_amount), .by = Batch) |> 
          mutate(Batch = my(Batch)) |> 
          filter(Batch == input$Current_Batch[1])
      
      valueBox(
        value = h5("Revenue"), width = 3,
        subtitle = tagList(#"Revenue progress",
                           shinyWidgets::progressBar(id = "test", value = revenue_header_sum_current$paid_amount, total = 200000000, display_pct = FALSE, striped = TRUE, status = "warning", size = "xs")
        ),
        icon = icon("sack-dollar"),
        color = "green")
        
        
      })
    
    
    # Deep Dive VIP
    ##  Rp = 0 vs Rp ≠ 0
    
    # pbi_by_rp <- ifelse(input$Growth_Type == "revenue", revenue, user)
      
    plot_rpInput <- reactive({
      switch(input$Growth_Type,
             "revenue" = revenue_rp <- pbi_free_vip_df_clean |>
               select(Batch, paid_amount) |>
               summarise(paid_amount = sum(paid_amount), .by = Batch) |> 
               mutate(Batch = my(Batch)) |> 
               filter(Batch >= input$Range_Batch[1] & Batch <= input$Range_Batch[2]) |>
               ggplot(aes(x = Batch, y = paid_amount)) +
               geom_col()
             
             ,
             
             
             
             "user" = user_rp <- pbi_free_vip_df_clean |>
               filter(Access.Tier != "free") |>
               select(Batch, amount_category) |>
               group_by(Batch, amount_category) |>
               count(Batch) |>
               rename(Total.Registrant = n) |>
               mutate(Total.Registrant = as.numeric(Total.Registrant), #) |>
                      Batch = my(Batch)) |>
               filter(Batch >= input$Range_Batch[1] & Batch <= input$Range_Batch[2]) |>
               ggplot(aes(x = Batch, y = Total.Registrant, fill = amount_category)) +
               geom_col(position = "dodge") +
               theme(axis.text.x=element_text(vjust = 1), legend.position = "none",
                     legend.title = element_text(inherit.blank = FALSE))
             
             )
      
    })
      
    output$total_pbi_by_rp <- renderPlotly({
      
      pbi_by_rp <- plot_rpInput()
      
      
      
    })
    
    
    
    
    
    
  

}








    # Test echarts4r
    
    # e_charts(pbi_free_vip_df_clean |>
    #   select(Batch, name, Access.Tier) |>
    #   group_by(Batch, Access.Tier) |>
    #   count(Batch) |>
    #   rename(Total.Registrant = n) |>
    #   mutate(Total.Registrant = as.numeric(Total.Registrant), #) |> 
    #          Batch = my(Batch)) |> 
    #   #filter(Batch >= input$Range_Batch[1] & Batch <= input$Range_Batch[2]) |> 
    #   e_bar(Access.Tier = vip, stack = "grp") |> 
    #   e_bar(Access.Tier = free, stack = "grp")
    # )






