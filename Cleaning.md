# Download Library and dataset + Cleaning Data

## Contents
- Importing library
- Loading dataset
- Cleaning data
- Changing factor
- Renaming columns
- Result

## Importing Library
1. ใช้ `readr` เพื่อการ read_csv
2. ใช้ `stringr` ในการ Clean data
3. ใช้ `dplyr` ในการ explore dataset
4. ใช้ `assertive`

## Loading dataset

แบบที่ 1 : โหลด [.csv]() มาไว้บนเครื่อง แล้วทำการอ้าง path
```
EV <- read.csv("C:\\Users\\ST\\Desktop\\IT2021\\INT214_Static-it\\027-Quickest-Electric-Cars\\Quickestelectriccars-EVDatabase.csv")
```
แบบที่ 2 : ใช้การ `read_csv` ผ่านทาง github โดยใช้ library readr ช่วย
```
EV <- read_csv("https://raw.githubusercontent.com/sit-2021-int214/027-Quickest-Electric-Cars/main/Quickestelectriccars-EVDatabase.csv")
```

## Cleaning Data
ทำการแปลงข้อมูลต่างๆ ให้อยู๋ในรูปที่เหมาะสม
โดยเนื่องจาก dataset ที่ได้มา มีความผิดพลาด + ต้อง clean มาก ทำให้ต้อง clean ในทุกๆ column ยกเว้น column Name และ Drive
```
#Clean Data
EV$Subtitle <- EV$Subtitle %>% str_sub(start = 27) %>% str_remove("kWh")%>% str_trim() %>% as.numeric()
EV$Acceleration <- EV$Acceleration %>% str_remove("sec") %>% str_trim() %>% as.numeric()
EV$Acceleration <- EV$Acceleration %>% str_remove("sec") %>% str_trim() %>% as.numeric()
EV$TopSpeed <- EV$TopSpeed %>% str_remove("km/h") %>% str_trim() %>% as.numeric()
EV$Range <- EV$Range %>% str_remove("km") %>% str_trim() %>% as.numeric()
EV$Efficiency <- EV$Efficiency %>% str_remove("Wh/km") %>% str_trim() %>% as.numeric()
EV$FastChargeSpeed <- EV$FastChargeSpeed %>% str_remove("km/h") %>% str_remove("-") %>% str_trim() %>% as.numeric() 
EV$PriceinGermany <- EV$PriceinGermany %>% str_remove("€") %>% str_remove(",") %>% str_trim() %>% as.numeric()
EV$PriceinUK <- EV$PriceinUK %>% str_remove("£") %>% str_trim()  %>% str_remove(",") %>% as.numeric()

```

## Changing factor
ใน Column Drive มีข้อมูลเพียงแค่ 3 ตัว ได้แก่
- All Wheel Drive
- Rear Wheel Drive
- Front Wheel Drive
จึงทำการเปลี่ยนชนิดของข้อมูลให้เป็น factor โดยการ
```
EV$Drive <- as.factor(EV$Drive)
```

## Renaming Columns
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

## Result
หลังจากทำการ Clean data แล้ว จะได้ผลลัพธ์ของข้อมูลดังนี้
|Column number|Column name|data type|
|-----------|-----------|------------|
|1|Name|character|



