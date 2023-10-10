

ui <- dashboardPage(
  dashboardHeader(title = "Rakamin Dashboard"),
  
  
  dashboardSidebar(
    
    sidebarMenu(
      
      menuItem("PBI", tabName = "pbi", icon = icon("dashboard"), startExpanded = TRUE,
               
               menuSubItem("Sales Performance", tabName = "sales_performance"),
               menuSubItem("Product Performance", tabName = "product_performance"),
               menuSubItem("Marketing Performance", tabName = "marketing_performance")
               
               
               ),
      menuItem("Learning", tabName = "learning", icon = icon("th"))
      
      
    )
    
  ),
  
  
  
  dashboardBody(

# Boxes need to be put in a row (or column)
      tabItems(
        # First tab content
        tabItem(tabName = "sales_performance",
                
                
                
                fluidRow(width = 12, # h3("Select Metric"), align = "center", 
                         
                         column(width = 6, align = "center", # h2("Under Developing")), 
                                
                                box(width = 12,  title = "Under Developing", status = "warning", background = "yellow", height = "10px")),
                         
                         column(width = 6, align = "center",
                                
                                # box(width = 12,  h6("Highlight"), background = "red", height = "20px"))),
                                
                                
                                box(width = 12, 
                                    solidHeader = TRUE, 
                                    title = "Compare Mode", 
                                    status = "primary", 
                                    collapsed = TRUE,
                                    collapsible = TRUE, #background = "light-blue",
                                    
                                    column(width = 6,
                                    
                                    
                                    airDatepickerInput(
                                      "Current_Batch",
                                      label = "Current Batch",
                                      value = pbi_total_registrant_by_batch$Batch,
                                      # maxDate = "2016-08-01",
                                      minDate = "2022-01-01",
                                      # range = TRUE,
                                      autoClose = TRUE,
                                      view = "months", #editing what the popup calendar shows when it opens
                                      minView = "months", #making it not possible to go down to a "days" view and pick the wrong date
                                      dateFormat = "MMM - yyyy"
                                      
                                    )),
                                    
                                    column(width = 6,
                                    
                                    airDatepickerInput(
                                      "Compered_Batch",
                                      label = "Compered Batch",
                                      value = pbi_total_registrant_by_batch$Batch,
                                      # maxDate = "2016-08-01",
                                      minDate = "2022-01-01",
                                      # range = TRUE,
                                      autoClose = TRUE,
                                      view = "months", #editing what the popup calendar shows when it opens
                                      minView = "months", #making it not possible to go down to a "days" view and pick the wrong date
                                      dateFormat = "MMM - yyyy"
                                      
                                    ))
                                    
                                ),
                                
                         )),
                                
                
                fluidRow(width = 12,                
                                
                                column(width = 12,
                                       
                                
                                # valueBox(10 * 2, "Revenue", width = 3, icon = icon("hand-holding-dollar"), color = "olive"),
                                
                                tags$head(tags$style(HTML('.small-box '))),
                                valueBoxOutput("revenue_header", width = 3),
                                
                                valueBox(10 * 2, "Spending", width = 3, icon = icon("sack-xmark"), color = "red"),
                                valueBox(10 * 2, "CAC", width = 3, icon = icon("comments-dollar"), color = "teal"),
                                valueBox(10 * 2, "ROI", width = 3, icon = icon("percent"), color = "yellow")
                                
                         
                         )
                         
                         ),
                
                fluidRow(
                  
                  tabBox(title = "", width = 12, 
                         
                         
                         tabPanel("Overview", 
                                  
                                  fluidRow(align = "center", 
                                           
                                                      # h2("Growth"),
                                           
                                           # br(),
                                                      
                                                      airDatepickerInput(
                                                        "Range_Batch",
                                                        label = "Range Batch",
                                                        value = pbi_total_registrant_by_batch$Batch,
                                                        # maxDate = "2016-08-01",
                                                        minDate = "2022-01-01",
                                                        range = TRUE,
                                                        autoClose = TRUE,
                                                        view = "months", #editing what the popup calendar shows when it opens
                                                        minView = "months", #making it not possible to go down to a "days" view and pick the wrong date
                                                        dateFormat = "MMM - yyyy" # , toggleSelected = TRUE
                                                        
                                                      ),
                                    
                                    tabBox(title = "", width = 12,
                                           
                                           tabPanel("Free vs VIP", 
                                                    
                                                    fluidRow(
                                                      
                                  
                                  column(width = 12, align = "center", #h4("Growth"),
                                  
                                  plotlyOutput(outputId = "total_registrant_pbi_by_batch"),
                                  
                                  br(),
                                  
                                  fluidRow(width = 12, align = "center", 
                                           
                                           box(width = 12, collapsible = TRUE, solidHeader = TRUE, collapsed = TRUE, title = "Optional Metric", status = "primary",
                                    
                                    column(width = 6,
                                  
                                  checkboxGroupButtons(
                                    inputId = "User",
                                    label = "User",
                                    choices = unique(pbi_total_registrant_by_batch$Access.Tier),
                                    justified = TRUE, 
                                    selected = c("vip", "free"),
                                    checkIcon = list(
                                      yes = icon("ok", 
                                                 lib = "glyphicon"))
                                  )),
                                  
                                  column(width = 6,
                                  
                                  prettyCheckboxGroup(
                                    inputId = "Id032",
                                    label = "Le Metric", 
                                    choices = c("CAC", 
                                                "Checkout Rate", 
                                                "Paid Rate", 
                                                "Target", 
                                                "Defisit" 
                                    ), 
                                    inline = TRUE,
                                    shape = "curve", 
                                    outline = TRUE, 
                                    status = "primary"
                                    # thick = TRUE
                                  ))

                                  ))),
                                  
                                  # column(width = 3, align = "center",
                                  #        
                                  #        box(width = 12, 
                                  #            title = "Metric", 
                                  #            solidHeader = TRUE, 
                                  #            status = "primary",
                                  #            
                                  #            fluidRow(
                                  #            # column(width = 6, 
                                  #            # 
                                  #            #        radioGroupButtons(
                                  #            #          inputId = "Id069",
                                  #            #          label = "Type", 
                                  #            #          choices = c(`<i class='fa-solid fa-money-bill'></i>` = "dollar", 
                                  #            #                      `<i class='fa-regular fa-user'></i>` = "user"), 
                                  #            #          justified = TRUE
                                  #            #        )
                                  #            # ),
                                  #            
                                  #            
                                  #              column(width = 12,
                                  #                
                                  #                     # radioGroupButtons(
                                  #                     # inputId = "Id066",
                                  #                     # label = "User",
                                  #                     # choices = c("Free", 
                                  #                     #             "VIP"),
                                  #                     # justified = TRUE
                                  #                     # )
                                  #                     
                                  #                     # checkboxGroupButtons(
                                  #                     #   inputId = "User",
                                  #                     #   label = "User",
                                  #                     #   choices = unique(pbi_total_registrant_by_batch$Access.Tier),
                                  #                     #   justified = TRUE, 
                                  #                     #   selected = c("vip", "free"),
                                  #                     #   checkIcon = list(
                                  #                     #     yes = icon("ok", 
                                  #                     #                lib = "glyphicon"))
                                  #                     # )
                                  #            
                                  #            
                                  #           )
                                  #              
                                  #            
                                  #            
                                  #            ),
                                  #            
                                  #            
                                  #            
                                  #            
                                  #            # airDatepickerInput(
                                  #            #   "Range_Batch",
                                  #            #   label = "Range Batch",
                                  #            #   value = pbi_total_registrant_by_batch$Batch,
                                  #            #   # maxDate = "2016-08-01",
                                  #            #   minDate = "2022-01-01",
                                  #            #   range = TRUE,
                                  #            #   autoClose = TRUE,
                                  #            #   view = "months", #editing what the popup calendar shows when it opens
                                  #            #   minView = "months", #making it not possible to go down to a "days" view and pick the wrong date
                                  #            #   dateFormat = "MMM - yyyy" # , toggleSelected = TRUE
                                  #            #   
                                  #            # ),
                                  #            
                                  #            fluidRow(
                                  #              column(width = 12, align = "left",
                                  #            
                                  #            prettyCheckboxGroup(
                                  #              inputId = "Id032",
                                  #              label = "Le Metric", 
                                  #              choices = c("CAC", 
                                  #                          "CR", 
                                  #                          "Paid Rate", 
                                  #                          "Target", 
                                  #                          "Defisit" 
                                  #                          ), 
                                  #              shape = "curve", 
                                  #              outline = TRUE, 
                                  #              status = "primary"
                                  #              # thick = TRUE
                                  #            )),
                                  #            
                                  #            # column(width = 6, align = "left",
                                  #            # 
                                  #            # prettyCheckboxGroup(
                                  #            #   inputId = "Id032",
                                  #            #   label = "Status", 
                                  #            #   choices = c("Paid", 
                                  #            #               "Pending", 
                                  #            #               "Expired"
                                  #            #               ), 
                                  #            #   shape = "curve", 
                                  #            #   outline = TRUE, 
                                  #            #   status = "primary"
                                  #            #   # thick = TRUE
                                  #            # ))
                                  #            
                                  #            ),
                                  #            
                                  #            # sliderTextInput(
                                  #            #   inputId = "Range_Price",
                                  #            #   label = "Range Price", 
                                  #            #   choices = sort(unique(pbi_total_registrant_by_batch$paid_amount)),
                                  #            #   selected = c(min(pbi_total_registrant_by_batch$paid_amount), max(pbi_total_registrant_by_batch$paid_amount)),
                                  #            #   grid = TRUE
                                  #            # ),
                                  #            
                                  #            # checkboxGroupButtons(
                                  #            #   inputId = "Amount_Category",
                                  #            #   label = "Amount",
                                  #            #   choices = unique(pbi_total_registrant_by_batch$amount_category),
                                  #            #   justified = TRUE,
                                  #            #   selected = c("Rp not Null","Rp Null"),
                                  #            #   checkIcon = list(
                                  #            #     yes = icon("ok", 
                                  #            #                lib = "glyphicon"))
                                  #            # )
                                  #           
                                  #            # checkboxGroupButtons(
                                  #            #   inputId = "Id058",
                                  #            #   label = "Paid Program Category",
                                  #            #   choices = c("Pre", 
                                  #            #               "In", 
                                  #            #               "Post"),
                                  #            #   justified = TRUE,
                                  #            #   checkIcon = list(
                                  #            #     yes = icon("ok", 
                                  #            #                lib = "glyphicon"))
                                  #            # )
                                  #            
                                  #        )
                                  #   
                                  # )
                                  
                                  
                           
                         )),
                         
                         tabPanel(
                           
                           "Deep Dive VIP", 
                           
                           fluidRow(width = 12,
                                    
                                    h3("Growth VIP"),
                             
                             column(width = 6,
                                    
                                    plotlyOutput(outputId = "total_pbi_by_rp")
                                    
                                    #h3("test column kiri atas")
                               
                             ),
                             
                             column(width = 6,
                                    
                                    h3("test column kanan atas")
                               
                             )
                             
                           ),
                           
                           fluidRow(width = 12,
                                    
                                    column(width = 6,
                                           
                                           h3("test column kiri bawah")
                                           
                                    ),
                                    
                                    column(width = 6,
                                           
                                           h3("test column kanan bawah")
                                           
                                    )
                                    
                           ),
                           
                           br(),
                           
                           fluidRow(width = 12, align = "center", 
                                    
                                    box(width = 12, collapsible = TRUE, solidHeader = TRUE, collapsed = TRUE, title = "Optional Metric", status = "primary",
                                        
                                        column(width = 6,
                                               
                                               radioGroupButtons(
                                                 inputId = "Growth_Type",
                                                 label = "Growth Type",
                                                 choices = c("revenue", "user"),
                                                 justified = TRUE,
                                                 selected = "revenue",
                                                 checkIcon = list(
                                                   yes = icon("ok",
                                                              lib = "glyphicon"))
                                               )
                                               
                                               
                                               ),
                                        
                                        column(width = 6,
                                               
                                               prettyCheckboxGroup(
                                                 inputId = "Status",
                                                 label = "Status", 
                                                 choices = c("Paid", 
                                                             "Pending", 
                                                             "Expired"
                                                 ), 
                                                 selected = c("Paid", 
                                                                 "Pending", 
                                                                 "Expired"
                                                 ), animation = "smooth",
                                                 bigger = TRUE,
                                                 inline = TRUE,
                                                 shape = "curve", 
                                                 outline = TRUE, 
                                                 status = "primary"
                                                 # thick = TRUE
                                               ))
                                        
                                    ))
                           
                           
                           
                         )
                         
                         
                         
                         
                         
                         
                         
                         
                         ))),
                         
                         tabPanel("Weekly", "Test tab"
                           
                           
                           
                         ),
                         
                         tabPanel("Daily", "Test tab"
                           
                           
                           
                         ),
                         
                         tabPanel("Funnels", "Test tab"
                           
                           
                           
                         ),
                    
                    
                    
                    
                  )
                  
                  
                  
                ),
                         
                                
                                
                                
                                
                         
                         
                         
                                
                                
                           
                
                
                
                
                
                
                
                ),
        
        tabItem(tabName = "product_performance",
                
                h2("Under Developing", align = "center")
                
                
        ),

                tabItem(tabName = "marketing_performance",
                        
                        h2("Under Developing", align = "center")
                
                
        ),
                
                
                
                
                
                
                

        
        
        
        
        
        
        
        
        
        
        
        
        # Second tab content -----------------------------------------
        tabItem(tabName = "learning",
                h2("Under Developing"), align = "center"
        )
      )
)

)





                # fluidRow(width = 12, align = "center", # h3("Overview"), 
                #          
                #          
                # 
                #   box(
                #     title = " Total Registrant", width = 9, align = "center",
                #     # plotlyOutput(outputId = "total_registrant_pbi_by_batch") # , height = "250px") # , width = "700px")
                #   ),
                #   
                #   box(width = 3, title = "Metric",
                #       
                #       selectInput("select", label = h5("Type"), 
                #                   choices = list("Revenue" = "Revenue", "User" = "User"), 
                #                   selected = "Revenue"),
                #       
                #       
                #       airDatepickerInput(
                #         "Range_Batch",
                #         # label = "Range Batch",
                #         value = pbi_total_registrant_by_batch$Batch,
                #         # maxDate = "2016-08-01",
                #         minDate = "2022-01-01",
                #         range = TRUE,
                #         autoClose = TRUE,
                #         view = "months", #editing what the popup calendar shows when it opens
                #         minView = "months", #making it not possible to go down to a "days" view and pick the wrong date
                #         dateFormat = "MMM - yyyy"
                #         
                #       )
                #       
                #   )
                #   
                #   
                #   
                # ),




                
                         # column(width = 3, align = "center",
                         #        
                         #        box(width = 12,  h4("Highlight"), background = "red")), #, height = "50px")
                         #        
                         #        
                         #        box(width = 12,
                         #            
                         #            
                         #            airDatepickerInput(
                         #              "Range_Batch",
                         #              # label = "Range Batch",
                         #              value = pbi_total_registrant_by_batch$Batch,
                         #              # maxDate = "2016-08-01",
                         #              minDate = "2022-01-01",
                         #              range = TRUE,
                         #              autoClose = TRUE,
                         #              view = "months", #editing what the popup calendar shows when it opens
                         #              minView = "months", #making it not possible to go down to a "days" view and pick the wrong date
                         #              dateFormat = "MMM - yyyy"
                         #              
                         #            )
                         #            
                         #        )
                                
                                
                
                
                # fluidRow(width = 12, # h3("Select Metric"), align = "center", 
                #              
                #          box(width = 12,
                #       
                #       
                #       airDatepickerInput(
                #         "Range_Batch",
                #         # label = "Range Batch",
                #         value = pbi_total_registrant_by_batch$Batch,
                #         # maxDate = "2016-08-01",
                #         minDate = "2022-01-01",
                #         range = TRUE,
                #         autoClose = TRUE,
                #         view = "months", #editing what the popup calendar shows when it opens
                #         minView = "months", #making it not possible to go down to a "days" view and pick the wrong date
                #         dateFormat = "MMM - yyyy"
                # 
                #         )
                #       
                #       ))
                
                

  # Date Range Box -------------------------------------------------

                    # 
                    #  airDatepickerInput(
                    #   "Range_Batch",
                    #   label = "Range Batch",
                    #   value = pbi_total_registrant_by_batch$Batch,
                    #   # maxDate = "2016-08-01",
                    #   minDate = "2022-01-01",
                    #   range = TRUE,
                    #   autoClose = TRUE, 
                    #   view = "months", #editing what the popup calendar shows when it opens
                    #   minView = "months", #making it not possible to go down to a "days" view and pick the wrong date
                    #   dateFormat = "MMM - yyyy"
                    #   
                    # ),