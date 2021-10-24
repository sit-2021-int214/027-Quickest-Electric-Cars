# Download Library and dataset + Cleaning Data
Dataset ที่ยังไม่ clean จะเป็นดังไฟล์นี้ : [Quickest Electric Cars-EVDatabase.csv](Quickestelectriccars-EVDatabase.csv)

## Contents
1. Importing library
2. Loading dataset
3. Cleaning data
4. Changing factor
5. Renaming columns
6. Result

## 1. Importing Library
- ใช้ `readr` เพื่อการ read_csv
- ใช้ `stringr` ในการ Clean data
- ใช้ `dplyr` ในการ explore dataset
- ใช้ `assertive` ในการเช็ค 

## 2. Loading dataset
ใช้การ `read_csv` ผ่านทาง github โดยใช้ library readr ช่วย
```
EV <- read_csv("https://raw.githubusercontent.com/sit-2021-int214/027-Quickest-Electric-Cars/main/Quickestelectriccars-EVDatabase.csv")
```

## 3. Cleaning Data
ทำการแปลงข้อมูลต่างๆ ให้อยู่ในรูปที่เหมาะสม
เนื่องจาก dataset ที่ได้มามีหน่วยต่อท้ายและมีความผิดพลาดมาก จึงต้อง clean ในทุกๆ column ยกเว้น column Name และ Drive
```
#Clean Data
EV$Subtitle <- EV$Subtitle %>% str_sub(start = 27) %>% str_remove("kWh")%>% str_trim() %>% as.numeric()
EV$Acceleration <- EV$Acceleration %>% str_remove("sec") %>% str_trim() %>% as.numeric()
EV$TopSpeed <- EV$TopSpeed %>% str_remove("km/h") %>% str_trim() %>% as.numeric()
EV$Range <- EV$Range %>% str_remove("km") %>% str_trim() %>% as.numeric()
EV$Efficiency <- EV$Efficiency %>% str_remove("Wh/km") %>% str_trim() %>% as.numeric()
EV$FastChargeSpeed <- EV$FastChargeSpeed %>% str_remove("km/h") %>% str_remove("-") %>% str_trim() %>% as.numeric() 
EV$PriceinGermany <- EV$PriceinGermany %>% str_remove("€") %>% str_remove(",") %>% str_trim() %>% as.numeric()
EV$PriceinUK <- EV$PriceinUK %>% str_remove("£") %>% str_trim()  %>% str_remove(",") %>% as.numeric()

```

## 4.Changing factor
ใน Column Drive มีข้อมูลเพียงแค่ 3 ชนิด ได้แก่
- All Wheel Drive
- Rear Wheel Drive
- Front Wheel Drive
จึงทำการเปลี่ยนชนิดของข้อมูลให้เป็น factor โดยการ
```
EV$Drive <- as.factor(EV$Drive)
```

## 5.Renaming Columns
ทำการเปลี่ยนชื่อ Column
- เพื่อให้สื่อความหมายมากขึ้น ได้แก่ Column Subtitle ให้เป็น Battery EV (kWh)  เพื่อให้สื่อถึงความจุแบตเตอร์รี่ของรถ
```
#Column Subtitle -> Battery EV (kWh)
EV <- EV %>% rename("Battery EV (kWh)" = Subtitle)
```
- เพื่อเพิ่มหน่วยของข้อมูล
```
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
```

## 6.Result
หลังจากทำการ Clean data แล้ว จะได้ผลลัพธ์ของข้อมูลดังนี้
|Column number|Old column name|New column name|Old data type|New data type|
|-----------|-----------|------------|----------|-----------|
|1|Name||character||
|2|Subtitle|Battery EV (kWh)|char|number|
|3|Acceleration| Acceleration(sec)|char|number|
|4|Topspeed|TopSpeed(km/h)|char|number|
|5|Range|Range(km)|char|number|
|6|Efficiency|Efficiency(wh/km)|char|number|
|7|FastChargeSpeed|FastChargeSpeed(km/h)|char|number|
|8|Drive||char|factor|
|9|PriceinGermany|PriceinGermany(€)|char|number|
|10|PriceinUK|PriceinUK(£)|char|number|

และได้ไฟล์ csv ที่ cleaned แล้ว ดังไฟล์นี้ [Cleaned-data.csv](Cleaned-data.csv)



