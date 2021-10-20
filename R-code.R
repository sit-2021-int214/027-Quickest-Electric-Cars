#Load Library
library(dplyr)
library(readr)      
library(stringr)
library(assertive)
library(ggplot2)


#Import dataset
EV <- read_csv("https://raw.githubusercontent.com/sit-2021-int214/027-Quickest-Electric-Cars/main/Quickestelectriccars-EVDatabase.csv")

#Explore the dataset
View(EV)
glimpse(EV)

#Cleaning Data
EV$Subtitle <- EV$Subtitle %>% str_sub(start = 27) %>% str_remove("kWh")%>% str_trim() %>% as.numeric()
EV$Acceleration <- EV$Acceleration %>% str_remove("sec") %>% str_trim() %>% as.numeric()
EV$TopSpeed <- EV$TopSpeed %>% str_remove("km/h") %>% str_trim() %>% as.numeric()
EV$Range <- EV$Range %>% str_remove("km") %>% str_trim() %>% as.numeric()
EV$Efficiency <- EV$Efficiency %>% str_remove("Wh/km") %>% str_trim() %>% as.numeric()
EV$FastChargeSpeed <- EV$FastChargeSpeed %>% str_remove("km/h") %>% str_remove("-") %>% str_trim() %>% as.numeric() 
EV$PriceinGermany <- EV$PriceinGermany %>% str_remove("€") %>% str_remove(",") %>% str_trim() %>% as.numeric()
EV$PriceinUK <- EV$PriceinUK %>% str_remove("£") %>% str_trim()  %>% str_remove(",") %>% as.numeric()

#Changing factor
EV$Drive <- as.factor(EV$Drive)

#Renaming Columns
#Column Subtitle -> Battery EV (kWh)
EV <- EV %>% rename("Battery EV (kWh)" = Subtitle)
#Column  Acceleration -> Acceleration(sec)
EV <- EV %>% rename("Acceleration(sec)" = Acceleration)
#Column TopSpeed -> TopSpeed(km/h)
EV <- EV %>% rename("TopSpeed(km/h)" = TopSpeed)
#Column Range -> Range(km)
EV <- EV %>% rename("Range(km)" = Range)
#Column Efficiency -> Efficiency(Wh/km)
EV <- EV %>% rename("Efficiency(Wh/km)" = Efficiency)
#Column FastChargeSpeed -> FastChargeSpeed(km/h) 
EV <- EV %>% rename("FastChargeSpeed(km/h)" = FastChargeSpeed)
#Column PriceinGermany -> PriceinGermany(€)
EV <- EV %>% rename("PriceinGermany(€)" = PriceinGermany)
#Column PriceinUK -> PriceinUK(£)
EV <- EV %>% rename("PriceinUK(£)" = PriceinUK)


#Exploratory Data Analysis to find answer
# 1.) ชุดข้อมูลนี้มีค่า NA มากน้อยแค่ไหน?
summary(is.na(EV))

# 2.) รถยี่ห้อใดที่มีความเร็วในการขับเร็วที่สุด?
EV %>% filter(`TopSpeed(km/h)`==max(`TopSpeed(km/h)`,na.rm = T))

# 3.) จงหาว่าชนิดของล้อที่ใช้ขับเคลื่อนมีกี่ชนิด และแต่ละแบบมีจำนวนเท่าใด?
EV$Drive <- as.factor(EV$Drive)
summary(EV$Drive)

# 4.) ราคาเฉลี่ยของรถในประเทศอังกฤษมีราคาสูงกว่าประเทศเยอรมันกี่ยูโร (ถ้า 1 ปอนด์สเตอร์ลิง(£) = 1.19 ยูโร(€))
EV$`PriceinGermany(€)` %>% mean(na.rm=T) 	# 58316.62 ยูโร
EV$`PriceinUK(£)` %>% mean(na.rm=T) 		  # 52449.87 ปอนด์สเตอร์ลิง

priceGermany <- EV$`PriceinGermany(€)` %>% mean(na.rm=T)
priceUK <- EV$`PriceinUK(£)` %>% mean(na.rm=T)

#แปลงหน่วยของ priceUK จากปอนด์สเตอร์ลิงเป็น priceGermany
priceUK <- priceUK*1.19 	  #62415.34 ยูโร

priceUK - priceGermany 	    #4098.725 ยูโร


# 5.) โดยเฉลี่ยแล้วค่าพลังงานของรถยนต์ไฟฟ้าทั่วไปใช้พลังงานเท่าไหร่?
EV$`Efficiency(Wh/km)` %>% mean(na.rm=T)
#or
mean(EV$`Efficiency(Wh/km)`,na.rm=T)

# 6.) ยิ่งความจุมากเท่าใด ความสามารถในการชาร์จพลังงานยิ่งเร็วขึ้นจริงไหม?
EV %>% select(`Battery EV (kWh)`,`FastChargeSpeed(km/h)`)
EV %>% na.omit() %>% ggplot(aes(x=`Battery EV (kWh)`,y=`FastChargeSpeed(km/h)`)) + geom_point()

# 7.) กลุ่มรถยนต์ไฟฟ้าที่รูปแบบล้อที่ใช้ขับเคลื่อนรูปแบบไหน มีประสิทธิภาพที่ดีสุด
#เทียบจาก Battery
EV %>% group_by(Drive) %>% select(Drive,`Battery EV (kWh)`) %>% 
    summarise(`Battery EV (kWh)` = mean(`Battery EV (kWh)`)) %>% arrange(desc(`Battery EV (kWh)`))

#เทียบจาก TopSpeed
EV %>% group_by(Drive) %>% select(Drive,`TopSpeed(km/h)`) %>% 
  summarise(`TopSpeed(km/h)` = mean(`TopSpeed(km/h)`)) %>% arrange(desc(`TopSpeed(km/h)`))

#เทียบจาก Range
EV %>% group_by(Drive) %>% select(Drive,`Range(km)`) %>% 
  summarise(`Range(km)` = mean(`Range(km)`)) %>% arrange(desc(`Range(km)`))

#เทียบจาก Efficiency ค่ายิ่งน้อย = ใช้พลังงานประหยัด
EV %>% group_by(Drive) %>% select(Drive,`Efficiency(Wh/km)`) %>% 
  summarise(`Efficiency(Wh/km)` = mean(`Efficiency(Wh/km)`)) %>% arrange(`Efficiency(Wh/km)`)

#เทียบจาก FastChargeSpeed
EV %>% group_by(Drive) %>% select(Drive,`FastChargeSpeed(km/h)`) %>% 
  summarise(`FastChargeSpeed(km/h)` = mean(`FastChargeSpeed(km/h)`,na.rm = T)) %>% arrange(desc(`FastChargeSpeed(km/h)`))


