install.packages("readxl")
library("readxl")
library(tidyverse)
library(ggplot2)

data <- read_excel("sugar_conc_xl.xlsx")
head(data)

str(data)
summary(data)
gglot
plot(data)

data |> ggplot(aes(x=hours, y=glucose_NI, fill))

#saving the plot

test <- read_excel("easy_data.xlsx")          
head(test)
str(test)

test |> 
  ggplot(aes(x = hours, y = glucose_NI)) +
  geom_point(color = "blue", size = 3)


test |>
  ggplot(aes(x = hours, y = glucose_NI)) +  # Removed the extra comma
  geom_point(color = "black", size = 3)    # Correct placement of `+`           



#trying something new = trying to plot multiple y values to the x 
str(data)


library(tidyr)

# Reshape the data into long format for both glucose and xylose
data_long <- data |> 
  pivot_longer(
    cols = starts_with("glucose") | starts_with("xylose"),  # Select glucose and xylose columns
    names_to = c("measurement_type", "group"),             # Split column names into two parts
    names_sep = "_",                                       # Separator between "glucose"/"xylose" and "NI"/"PI"/"Shi"
    values_to = "value"                                    # New column for the values
  )

# View the reshaped data
print(data_long)


#plot the data
library(ggplot2)

# Plot the data
ggplot(data_long, aes(x = hours, y = value, color = group, linetype = measurement_type, shape = group)) +
  geom_point(size = 3) +  # Add points
  geom_line() + # Add lines connecting the points
  scale_shape_manual(values = c("NI" = 16, "PI" = 17, "Shi" = 18)) +
  labs(
    x = "Hours",
    y = "Sugar concentation",
    color = "Group",
    linetype = "Measurement Type",
    shape = "Measurment Type"
  ) +
  theme_minimal()



# Try again
ggplot(data_long, aes(x = hours, y = value, color = group, shape = group, linetype = measurement_type)) +
  geom_point(size = 3) +  # Add points with different shapes
  geom_line() +           # Add lines with different linetypes
  scale_shape_manual(values = c("NI" = 16, "PI" = 17, "Shi" = 15)) +  # Custom shapes for groups
  scale_color_manual(values = c("NI" = "#66c2a5", "PI" = "#fc8d62", "Shi" = "#8da0cb")) +  # Custom colors for groups
  labs(
    x = "Hours",
    y = "Sugar concentration",
    color = "Treatment",
    shape = "Treatment",  # Combine color and shape into one legend
    linetype = "Sugar"  # Keep linetype for measurement type
  ) +
  theme_minimal() +
  guides(
    shape = guide_legend(override.aes = list(linetype = "blank")),  # Remove linetype from shape legend
    color = guide_legend(override.aes = list(linetype = "blank"))   # Remove linetype from color legend
  )


#Renaming the label
final_plot <-
ggplot(data_long, aes(x = hours, y = value, color = group, shape = group, linetype = measurement_type)) +
  geom_point(size = 3) +
  geom_line() +
  scale_shape_manual(
    values = c("NI" = 16, "PI" = 17, "Shi" = 15),  # Shapes for each group
    labels = c("NI" = "Non Isothermal", "PI" = "Partially isothermal", "Shi" = "Raw Shiitake")  # Override labels
  ) +
  scale_color_manual(
    values = c("NI" = "#66c2a5", "PI" = "#fc8d62", "Shi" = "#8da0cb"),  # Custom colors for groups
    labels = c("NI" = "Non Isothermal", "PI" = "Partially isothermal", "Shi" = "Raw Shiitake")  # Override labels
  ) +
  scale_linetype_manual(
    values = c("glucose" = "solid", "xylose" = "dashed"),
    labels = c("glucose" = "Glucose", "xylose" = "Xylose")
  ) +
  labs(
    x = "Hours (t)",
    y = "Average sugar concentration (g/L)",
    color = "Treatment",
    shape = "Treatment",
    linetype = "Sugar",
    title = "Sugar Kinetics",
    caption = "Preparative enzymatic saccharification of SMS.\nAverage of triplicate measurments"
  ) +
  theme_minimal() +
theme(
  plot.background = element_rect(fill = "white", color = NA),  # Set plot background to white
  plot.title = element_text(size = 25, hjust = 0.5),
  axis.title.x = element_text(size = 18),
  axis.title.y = element_text(size = 18),
  axis.text = element_text(size = 15),
  plot.caption = element_text(face = "italic", hjust = 0)
)

#saving the plot
ggsave("sugar_kinetic_2.png", plot = final_plot, width = 8, height = 6, dpi = 300)




#Trying a different plot type (histogram)

ggplot(data_long, aes(x = value)) +
  geom_histogram() +
  labs(
    x = "Hours (t)",
    y = "Average sugar concentration (g/L)",
  ) +
  theme_minimal()


# Box plot try out
ggplot(data_long, aes(x = as.factor(hours), y = value, fill = group, color = group)) +
  geom_boxplot() +
  facet_wrap(~measurement_type) +  # Separate panels for glucose and xylose
  labs(
    x = "Time (hours)",
    y = "Sugar Concentration (g/L)",
    fill = "Treatment Group",
    color = "Treatment Group",
    title = "Distribution of Sugar Concentration Over Time"
  ) +
  theme_minimal()

# New plot different colors
final_plot2 <-
  ggplot(data_long, aes(x = hours, y = value, color = group, shape = group, linetype = measurement_type)) +
  geom_point(size = 3) +
  geom_line() +
  scale_shape_manual(
    values = c("NI" = 16, "PI" = 17, "Shi" = 15),  # Shapes for each group
    labels = c("NI" = "Non Isothermal", "PI" = "Partially isothermal", "Shi" = "Raw Shiitake")  # Override labels
  ) +
  scale_color_manual(
    values = c("NI" = "red", "PI" = "green", "Shi" = "purple"),  # Custom colors for groups
    labels = c("NI" = "Non Isothermal", "PI" = "Partially isothermal", "Shi" = "Raw Shiitake")  # Override labels
  ) +
  scale_linetype_manual(
    values = c("glucose" = "solid", "xylose" = "dashed"),
    labels = c("glucose" = "Glucose", "xylose" = "Xylose")
  ) +
  labs(
    x = "Hours (t)",
    y = "Average sugar concentration (g/L)",
    color = "Treatment",
    shape = "Treatment",
    linetype = "Sugar",
    title = "Sugar Kinetics",
    caption = "Preparative enzymatic saccharification of SMS.\nAverage of triplicate measurments"
  ) +
  theme_minimal() +
  theme(
    plot.background = element_rect(fill = "white", color = NA),  # Set plot background to white
    plot.title = element_text(size = 25, hjust = 0.5),
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18),
    axis.text = element_text(size = 15),
    plot.caption = element_text(face = "italic", hjust = 0)
  )

#saving the plot
ggsave("sugar_kinetic_1.png", plot = final_plot2, width = 8, height = 6, dpi = 300)


# New plot different symbols
final_plot3 <-
  ggplot(data_long, aes(x = hours, y = value, color = group, shape = group, linetype = measurement_type)) +
  geom_point(size = 3) +
  geom_line() +
  scale_shape_manual(
    values = c("NI" = 21, "PI" = 5, "Shi" = 13),  # Shapes for each group
    labels = c("NI" = "Non Isothermal", "PI" = "Partially isothermal", "Shi" = "Raw Shiitake")  # Override labels
  ) +
  scale_color_manual(
    values = c("NI" = "blue", "PI" = "green", "Shi" = "purple"),  # Custom colors for groups
    labels = c("NI" = "Non Isothermal", "PI" = "Partially isothermal", "Shi" = "Raw Shiitake")  # Override labels
  ) +
  scale_linetype_manual(
    values = c("glucose" = "solid", "xylose" = "dashed"),
    labels = c("glucose" = "Glucose", "xylose" = "Xylose")
  ) +
  labs(
    x = "Hours (t)",
    y = "Average sugar concentration (g/L)",
    color = "Treatment",
    shape = "Treatment",
    linetype = "Sugar",
    title = "Sugar Kinetics",
    caption = "Preparative enzymatic saccharification of SMS.\nAverage of triplicate measurments"
  ) +
  theme_minimal() +
  theme(
    plot.background = element_rect(fill = "white", color = NA),  # Set plot background to white
    plot.title = element_text(size = 25, hjust = 0.5, face = "bold.italic"),
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18),
    axis.text = element_text(size = 15),
    plot.caption = element_text(face = "italic", hjust = 0)
  )

final_plot3
#saving the plot
ggsave("sugar_kinetic_3.png", plot = final_plot3, width = 8, height = 6, dpi = 300)






## Adding standard deviation to the plot

library(tidyr)
library(dplyr)
library("readxl")
library(tidyverse)

data <- read_excel("sugar_conc_xl.xlsx")

# Reshape the data into long format for both glucose/xylose and their standard deviations
data_long <- data |> 
  pivot_longer(
    cols = starts_with("glucose") | starts_with("xylose"),  # Select glucose and xylose columns
    names_to = c("measurement_type", "group"),             # Split column names into two parts
    names_sep = "_",                                       # Separator between "glucose"/"xylose" and "NI"/"PI"/"Shi"
    values_to = "value"                                    # New column for the values
  )

print(data_long)

# Reshape the standard deviations into long format
std_dev_long <- data |> 
  pivot_longer(
    cols = starts_with("std.dev."),                          # Select standard deviation columns
    names_to = c("measurement_type", "group"),             # Split column names into two parts
    names_sep = "_",                                       # Separator between "st_dev_glucose"/"st_dev_xylose" and "NI"/"PI"/"Shi"
    values_to = "std.dev"                                  # New column for the standard deviations
  )

print(std_dev_long)

# Combine the two long-format data frames
data_long <- data_long |> 
  left_join(std_dev_long, by = c("hours", "measurement_type", "group"))



#Plot the graph with stdev
ggplot(data_long, aes(x = hours, y = value, color = group, shape = group, linetype = measurement_type)) +
  geom_point(size = 3) +  # Add points
  geom_line() +           # Add lines connecting the points
  geom_errorbar(aes(ymin = value - std.dev, ymax = value + std.dev),  # Add error bars
                width = 0.5,  # Width of the error bars
                color = "black") +  # Error bars in black
  labs(
    x = "Hours",
    y = "Sugar Concentration",
    color = "Group",
    shape = "Group",
    linetype = "Measurement Type"
  ) +
  theme_minimal()



# saving the last plot
ggsave("sugar_kinetic_1.png", plot = last_plot(), width = 8, height = 6, dpi = 300)
