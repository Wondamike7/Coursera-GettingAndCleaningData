library(swirl)
swirl()
mydf <- read.csv(path2csv,stringsAsFactors=FALSE)
library(dplyr)
packageVersion("dplyr")
cran <- tbl_df(mydf)
rm("mydf")
cran
select(cran, ip_id, package, country)
select(cran,r_arch:country)
select(cran,country:r_arch)
select(cran,-time)
select(cran,-(X:size))
filter(cran, package=="swirl")
filter(cran, r_version=="3.1.1", country=="US")
filter(cran, r_version<="3.0.2", country=="IN")
filter(cran, country=="US" | country=="IN")
filter(cran,size>100500,r_os=="linux-gnu")
filter(cran,!is.na(r_version))

cran2 <- select(cran,size:ip_id)
arrange(cran2, ip_id)
arrange(cran2, desc(ip_id))
arrange(cran2, package, ip_id)
arrange(cran2,country,desc(r_version),ip_id)

cran3 <- select(cran,ip_id,package,size)
mutate(cran3, size_mb = size / 2^20)
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb/ 2^10)
mutate(cran3, correct_size = size + 1000)
summarize(cran, avg_bytes = mean(size))

by_package <- group_by(cran,package)
summarize(by_package,mean(size))
## submit()
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))
quantile(pack_sum$count, probs = 0.99)
top_counts <- filter(pack_sum, count > 679)

top_counts_sorted <- arrange(top_counts,desc(package))
top_counts_sorted <- arrange(top_counts,desc(count))

quantile(pack_sum$unique, probs = 0.99)
top_unique <- filter(pack_sum, unique > 465)
top_unique_sorted <- arrange(top_unique,desc(unique))

result3 <-
  cran %>%
  group_by(package) %>%
  summarize(count = n(),
            unique = n_distinct(ip_id),
            countries = n_distinct(country),
            avg_bytes = mean(size)
  ) %>%
  filter(countries > 60) %>%
  arrange(desc(countries), avg_bytes)

# Print result to console
print(result3)

cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>%
  arrange(desc(size_mb)) %>%
	print

library(tidyr)
gather(students, sex, count, -grade)

res <- gather(students2,sex_class, count, -grade)

separate(data=res, col=sex_class, into=c("sex","class"))

## also learned spread()

passed <- mutate(passed,status="passed")
failed <- mutate(failed, status="failed")
bind_rows(passed,failed)

sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  group_by(part,sex)  %>%
  mutate(total = sum(count), prop = count / total) %>% 
  print

Sys.getlocale("LC_TIME")
library(lubridate)
help(package=lubridate)
this_day <- today()
year(this_day)
class(year(this_day))
wday(this_day)
wday(this_day,label=TRUE)

now()
this_moment <- now()
hour(this_moment)

my_date <- ymd("1989-05-17")
class(my_date)
ymd("1989 May 17")
mdy("March 12, 1975")
dmy(25081985)
ymd("192012") ## doesn't work
ymd("1920/1/2")

dt1
ymd_hms(dt1)
hms("03:22:14")

dt2
ymd(dt2)
update(this_moment, hours = 8, minutes = 34, seconds = 55)
this_moment <- update(this_moment, hours = 14, minutes = 9)

nyc <- now(tzone="America/New_York")
depart <- nyc + days(2)
depart <- update(depart, hours=17, minutes=34)
arrive <- depart + hours(15) + minutes(50)
with_tz(arrive, tzone="Asia/Hong_Kong")
arrive <- with_tz(arrive, tzone="Asia/Hong_Kong")

last_time <- mdy("June 17, 2008", tz = "Singapore")
how_long <- new_interval(last_time, arrive)
as.period(how_long)
stopwatch()

this_moment - last_time
arrive - last_time