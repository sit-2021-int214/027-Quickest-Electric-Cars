# Group027-Quickest-Electric-Cars

![EV car](EVcar.jpeg)

Datasets from: [Quickest Electric Cars](https://www.kaggle.com/kkhandekar/quickest-electric-cars-ev-database?select=Quickestelectriccars-EVDatabase.csv)

## Overview
ข้อมูลชุดนี้เป็นข้อมูลเกี่ยวกับ Electric Vehicles หรือรถยนต์ไฟฟ้าของแต่ละรุ่นที่วางขายในตลาดของทวีปยุโรป เพื่อใช้เป็นข้อมูลในการวางแผนการลงทุนเทคโนโลยีด้านยานพาหนะที่มีประโยชน์ต่อสิ่งแวดล้อม
โดยมีจำนวนข้อมูลทั้งหมด 179 ข้อมูล มีทั้งหมด 11 คอลัมน์ ได้แก่ 
||Column Name|Column descirption|Unit|Data type|
|----|---------|--------------|-----|-------|
|1|Name|ชื่อยี่ห้อและรุ่นของรถ||character|
|2|Subtitle|ความจุแบตเตอรี่ของรถ|kwh|character|
|3|Acceleration|อัตราการเร่ง เมื่อรถเปลี่ยนความเร็ว|sec|character|
|4|TopSpeed|ความเร็วสูงสุด|km/h|character|
|5|Range|ค่าระยะทางที่รถสามารถวิ่งได้ จนพลังงานนั้นหมด|km|character|
|6|Efficiency|ค่าพลังงานทีใช้ไปต่อชั่วโมง|Wh/km|character|
|7|Fast Charge Speed|ความเร็วในการชาร์จแบตเตอรี่|km/h|character|
|8|Drive|รูปแบบล้อที่ใช้ขับเคลื่อน||character|
|9|Number of Seats|จำนวนที่นั่ง||double|
|10|Price in Germany|ราคารถในประเทศเยอรมัน|€(ยูโร)|character|
|11|Price in UK|ราคาในประเทศอังกฤษ|£(ปอนด์สเตอร์ลิง)|character| 

### Steps
1. Explore the dataset from the original dataset
2. Define a question
3. Download Library and dataset
4. Data Cleaning and Data Transformation
5. Exploratory Data Analysis to find the answer

### Tools
- Google docs
- R Language
- R Studio Desktop
- Website kaggle
- Visual studio
- Power BI Desktop

### Table of Contents
1. [Download Library and dataset + Data Cleaning and Data Transformation](./Cleaning.md)
2. [Answer the question](./Answer.md)
3. [Data Visualizations](https://app.powerbi.com/view?r=eyJrIjoiZWMyOWI0MjMtYzk2MC00NDAzLTllMDAtODcwNDVhZjkwYWNhIiwidCI6IjZmNDQzMmRjLTIwZDItNDQxZC1iMWRiLWFjMzM4MGJhNjMzZCIsImMiOjEwfQ%3D%3D&pageName=ReportSection)
4. [Hypothesis Testing](./Hypothesis-testing.md)

## Resources
Important Files in Repository
* [Test-data.R](./R-code.R) : Data Cleaning and Data Transformation 
* [Quickest Electric Cars](./Quickestelectriccars-EVDatabase.csv) : Original Dataset
* [Quickest Electric Cars Ver.2](./Cleaned-data.csv) : Cleaned Dataset
* [Hypothesis Testing](./Hypothesis.R)

## About Us
งานนี้เป็นส่วนของวิชา INT214 Statistics for Information technology <br/> ภาคเรียนที่ 1 ปีการศึกษา 2564 คณะเทคโนโลยีสารสนเทศ มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าธนบุรี

### Team: name : นึกไม่ออกขอ A แทนละกัน
1. พรธิชา    แสงมณี               StudentID: 63130500084
2. พิรญาณ์   สุทธิปริญญานนท์          StudentID: 63130500087
3. วิชชุตา    พิภพภิญโญ             StudentID: 63130500106
4. กรรณิการ์  งาสุวรรณ์             StudentID: 63130500147
5. เกศดารา  ศิลารัตน์              StudentID: 63130500149

### Instructor
- ATCHARA TRAN-U-RAIKUL
- JATAWAT XIE (Git: [safesit23](https://github.com/safesit23))



