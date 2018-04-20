# ===================================================================
# Master file for Fall 2017 DSS R Workshop
# ===================================================================



######## Assigning variables
apples <- _____
oranges <- _____
bananas <- _____
grapes <- _____
my_fruits <- _____
more_fruits <- _____
even_more_fruits <- _____




######## Vectors
midterm_grades <- c(97, 81, 65, 83, 92, 76, 82)
midterm_grades

mean(midterm_grades)
_____(midterm_grades)
_____(midterm_grades, _____)
_____(midterm_grades)

# -----Practice: Find 75th percentile, maximum, and mode ------------



# -------------------------------------------------------------------

_____(midterm_grades)

students <- c('Alfonso', 'Barbara', 'Craig', 'Danielle', 'Erica', 'Felix', 'Gary')
names(_____) <- _____
midterm_grades

final_grades <- c(46, 99, 91, 85, 85, 78, 96)
overall <- 0.5 * _____ + 0.5 * _____
overall

overall[_____]
overall[_____]
overall[_____] > overall[_____]

overall[c('Alfonso', 'Erica')]
overall[c(_____, _____, _____, _____, _____, _____, _____)]
_____ <- c(TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE)
overall[_____]
overall > _____(_____)




######## Matrices
my_matrix <- _____(c(1,2,3,4,5,6,7,8,9), _____=3, _____=3)
my_matrix  

my_matrix <- matrix(_____, nrow=3, ncol=3, _____=TRUE)        
my_matrix                               

# --Practice: Make a matrix with Harry Potter box office data -------
# Harry Potter movies link: 
#    http://www.the-numbers.com/movies/franchise/Harry-Potter#tab=summary
# Goals: 
#   - Create a matrix with tidy data (what does that mean?)
#       - Don't worry about the exact number, just round to the nearest million
#   - Set the row and column names (hint: try ??'row names', etc.)
#   - Print out the matrix
#   - Print out basic statistics about the matrix
# Two vectors provided below to save you (some) busy work!

c('sorcerer', 'chamber', 'prisoner', 'goblet', 
  'order', 'prince', 'deathly1', 'deathly2')
c('domestic', 'worldwide')

sorcerer <- c(317, 974)
chamber <- c(261, 878)
prisoner <- c(___, ___)
goblet <- c(___, ___)
order <- c(___, ___)
prince <- c(___, ___)
deathly1 <- c(___, ___)
deathly2 <- c(___, ____)

potter <- matrix(c(sorcerer, chamber, prisoner, goblet, order, 
                   prince, deathly1, deathly2), nrow= ____, ncol= ____)
rownames(potter) <- movie_names
________(potter) <- c('domestic', 'worldwide')

potter
summary(potter)
# -------------------------------------------------------------------


dim(potter)
str(potter)

potter[, 'domestic']
potter['deathly2',]

plot(potter[,'domestic'], potter[,'worldwide'], main='Harry Potter Box Office', 
     xlab='Domestic ($, millions)', ylab='Worldwide ($, millions)')






######## readr
install.packages('readr')
library(readr)

titanic <- read_csv('titanic.csv')           # titanic <- read.csv('titanic.csv')

head(titanic)
summary(titanic)
str(titanic)

titanic$age <- as.integer(titanic$age)
titanic[titanic=='??'] <- NA
titanic$sex <- as.factor(titanic$sex)
titanic$embarked <- as.factor(titanic$embarked)
str(titanic)

titanic <- read_csv('titanic.csv',
                    na='??',
                    col_types=cols(sex=col_factor(levels=c('male', 'female')),
                                   embarked=col_factor(levels=c('S', 'C', 'Q'))))
str(titanic)





######## dplyr
install.packages('dplyr')
library(dplyr)

# select
colnames(titanic)
titanic2 <- select(titanic, passenger_ID, survived, class, name, 
                   sex, age, sib_sp, par_ch, fare, embarked)
titanic2 <- select(titanic, -ticket, -cabin)          # minus(-) in R means "except for"

# mutate
titanic2 <- mutate(titanic2, fam=sib_sp+par_ch)

# filter
filter(titanic2, embarked=='S')


# arrange
arrange(titanic2, age)
arrange(titanic2, desc(fare))

# summarize
titanic2 <- na.omit(titanic2)
summarize(titanic2, mean(survived))
summarize(titanic2, mean(age))
mean(titanic2$survived)
mean(titanic2$age)

summarize(group_by(titanic2, class), mean(survived))
summarize(group_by(titanic2, sex), mean(survived))


# ----- PRACTICE ----------------------------------------------------
#Display males who embarked from Southampton and paid more than $50 for fare
filter(_______, sex== _____, embarked== _______, _________)

#Display only people who embarked from Queenstown (Q) or Chersbourg (C)
filter(titanic2, ____________  __  _____________)

#Display females who embarked from Queenstown, in descending age
_______(_________(___________, ___________), _________)

#Display the passenger ID and number of family members of females who survived
_______(________(________, ___________, survived==_________), passenger_ID, fam)

#Display the percentage of survival and average age for each class
summarize(group_by(__________, ____________), mean(_________), mean(_________))

#Display the percentage of survival, median age, and average fare for 
#each combination of gender and class (i.e. male and 1, female and 2, etc.)
summarize(________)
#--------------------------------------------------------------------



######## ggplot2
install.packages('ggplot2')
library(ggplot2)


## Anatomy of ggplot2 

# ggplot(
#   data = [dataframe], 
#   aes(
#     x = [var_x], y = [var_y], 
#     color = [var_for_color], 
#     fill = [var_for_fill], 
#     shape = [var_for_shape]
#   )
# ) +
#   geom_[some_geom]([geom_arguments]) +
#   ... # other geometries
# scale_[some_axis]_[some_scale]() +
#   facet_[some_facet]([formula]) +
#   ... # other options



potter_df <- as.data.frame(potter)
ggplot(potter_df, aes(domestic, worldwide)) +
  geom_point(color='red') +
  geom_text(label=rownames(potter_df), nudge_y=25) +
  ggtitle('Harry Potter Box Office Results') +
  xlab('Domestic ($, millions)') +
  ylab('Worldwide ($, millions)')

ggplot(titanic2, aes(age, fare)) +
  geom_point()

ggplot(titanic2, aes(age, fare)) +
  geom_point() +
  geom_smooth()

ggplot(titanic, aes(age)) +
  geom_histogram()

ggplot(titanic, aes(age)) + 
  geom_histogram(aes(fill=sex))

ggplot(titanic2, aes(survived)) +
  geom_bar()

ggplot(titanic2, aes(survived)) +
  geom_bar() + 
  facet_grid( ~ class)

ggplot(titanic2, aes(survived)) +
  geom_bar(aes(fill=sex)) + 
  facet_grid( ~ class)


# ----------------- MORE PRACTICE WITH GGPLOT -----------------

library(readr)
movies <- read_csv("~/Downloads/movies.csv")
View(movies)

# INITIAL VISUALIZATION
ggplot(data = movies, aes(x = audience_score, y = critics_score)) + geom_point()

# ALTERING FEATURES
ggplot(data = movies, aes(x = audience_score, y = critics_score)) +
  geom_point(alpha = 0.5, color = "blue")


# FACETING
ggplot(data = movies, aes(x = audience_score, y = critics_score, color = genre)) +
  geom_point(alpha = 0.5) +
  facet_grid(. ~ title_type)

# How did the plot change? 

# MORE FACETING
movies2 = movies[!is.na(movies$audience_rating), ]
ggplot(data = movies2, aes(x = audience_score, y = critics_score, color = genre)) +
  geom_point(alpha = 0.5) +
  facet_grid(audience_rating ~ title_type)


# EVEN MORE FACETING
ggplot(data = movies, aes(x = audience_score, y = critics_score, color = title_type)) +
  geom_point(alpha = 0.5) +
  facet_wrap(~genre)


# HISTOGRAMS
ggplot(data = movies, aes(x = critics_score, fill = genre)) +
  geom_histogram(binwidth = 3)

# DENSITY PLOT
ggplot(data = movies, aes(x = runtime, color = audience_rating)) +
  geom_density() 

# create a limit for y-axis and x-axis...     
ggplot(data = movies, aes(x = runtime, fill = audience_rating)) +
  geom_density(alpha = 0.5) + ylim(0, .04) + xlim(0, 200)


# MORE SCATTER PLOTS
ggplot(data = movies, aes(x = imdb_rating, y = audience_score)) +
  geom_point(alpha = 0.5) 


# SMOOTHING
ggplot(data = movies, aes(x = imdb_rating, y = audience_score)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm")


# BAR PLOTS
ggplot(data = movies, aes(x = genre)) +
  geom_bar()

# format labels
ggplot(data = movies, aes(x = genre)) +
  geom_bar() + theme(axis.text.x=element_text(angle = 45))

# more so...
ggplot(data = movies, aes(x = genre)) +
  geom_bar() + theme_get() + theme(axis.text.x=element_text(angle = 45, hjust = 1))


movies$thtr_rel_date_str <- sprintf("%04d-%02d-%02d",
                                    movies$thtr_rel_year,
                                    movies$thtr_rel_month,
                                    movies$thtr_rel_day)

movies$dvd_rel_date_str <- sprintf("%04d-%02d-%02d",
                                   movies$dvd_rel_year,
                                   movies$dvd_rel_month,
                                   movies$dvd_rel_day)

movies$thtr_rel_date <- as.Date(movies$thtr_rel_date_str)
movies$dvd_rel_date <- as.Date(movies$dvd_rel_date_str)
movies$dvd_rel_delay <- movies$dvd_rel_date - movies$thtr_rel_date

ggplot(data = movies, aes(x = critics_score, y = audience_score, color = mpaa_rating)) +
  geom_point()


# ---------------------------------------------------


######## Random Tidbits
# & vs &&, | vs ||
(-2:2 > 0) & (-1:3 > 0)
(-2:2 > 0) && (-1:3 > 0)

(-2:2 > 0) | (-1:3 > 0)
(-2:2 > 0) || (-1:3 > 0)

# Indexing begins at 1
some_vector <- c(1,2,3,4,5)
some_vector[2]

# Piping
summarize(group_by(titanic2, class), mean(survived), mean(age))

titanic2 %>% 
  group_by(class) %>%
  summarize(mean(survived), mean(age))