# Answer the question

## Define a question
1. รถที่สามารถบรรจุแบตเตอรี่ได้มากจะมีผลต่อประสิทธิภาพที่นำไปใช้งานไหม
2. รถยี่ห้อใดที่มีความเร็วในการขับเร็วที่สุด
3. จงหาว่าชนิดของล้อที่ใช้ขับเคลื่อนมีกี่ชนิด และแต่ละแบบมีจำนวนกี่รุ่น
4. ราคาเฉลี่ยของรถในประเทศอังกฤษมีราคาสูงกว่าประเทศเยอรมันกี่ยูโร (ถ้า 1 ปอนด์สเตอร์ลิง(£) เท่ากับ 1.19 ยูโร(€))
5. ยิ่งความจุมากเท่าใด ความสามารถในการชาร์จพลังงานยิ่งเร็วขึ้นจริงไหม
6. โดยเฉลี่ยแล้วค่าพลังงานของรถยนต์ไฟฟ้าใช้ไปต่อชั่วโมง ใช้พลังงานเท่าไหร่

## Answer the question
### 1.) รถที่สามารถบรรจุแบตเตอรี่ได้มากจะมีผลต่อประสิทธิภาพที่นำไปใช้งานไหม?
Code
```ruby
EV %>% select(`Battery EV (kWh)`, `Efficiency(Wh/km)`)
```
Result
```
`Battery EV (kWh)` `Efficiency(Wh/km)`
                <dbl>               <dbl>
 1              200                   206
 2               90                   198
 3               83.7                 215
 4               83.7                 220
 5              200                   267
 6              110                   167
 7               90                   162
 8               83.7                 209
 9               76                   162
10               85                   210
# ... with 169 more rows
```
**Answer 1** : ความจุมากไม่ได้แปลว่าประสิทธิภาพในการใช้งานจะดีเสมอไป

### 2.) รถยี่ห้อใดที่มีความเร็วในการขับเร็วที่สุด?
Code
```ruby
EV %>% filter(`TopSpeed(km/h)`==max(`TopSpeed(km/h)`,na.rm = T))
```
Result
```
# A tibble: 1 x 11
  Name           `Battery EV (kW~ `Acceleration(s~ `TopSpeed(km/h)` `Range(km)` `Efficiency(Wh/~ `FastChargeSpee~ Drive NumberofSeats
  <chr>                     <dbl>            <dbl>            <dbl>       <dbl>            <dbl>            <dbl> <fct>         <dbl>
1 Tesla Roadster              200              2.1              410         970              206              920 All ~             4
# ... with 2 more variables: PriceinGermany(€) <dbl>, PriceinUK(£) <dbl>
```
**Answer 2** : รถรุ่น Tesla Roadster มีความเร็วที่สุด

### 3.) จงหาว่าชนิดของล้อที่ใช้ขับเคลื่อนมีกี่ชนิด และแต่ละแบบมีจำนวนกี่รุ่น?
Code
```ruby
EV$Drive <- as.factor(EV$Drive)
summary(EV$Drive)
```
Result
```
    All Wheel Drive     Front Wheel Drive       Rear Wheel Drive 
                 63                    71                     45 
```
**Answer 3** : ชนิดของล้อในการขับเคลื่อนแบ่งออกได้ 3 ประเภท ด้วยกันคือ All wheel drive มีรถที่ใช้ระเภทนี้อยู่ทั้งหมด 63 รุ่น ส่วนRear wheel drive มีรถที่ใช้ประเภทนี้อยู่ทั้งหมด 71 รุ่น และ Front wheel drive มีรถที่ใช้ระเภทนี้อยู่ทั้งหมด 45 รุ่น

### 4.) ราคาเฉลี่ยของรถในประเทศอังกฤษมีราคาสูงกว่าประเทศเยอรมันกี่ยูโร (ถ้า 1 ปอนด์สเตอร์ลิง(£) เท่ากับ 1.19 ยูโร(€))
Code
```ruby
EV$`PriceinGermany(€)` %>% mean(na.rm=T) 	# 58316.62 ยูโร
EV$`PriceinUK(£)` %>% mean(na.rm=T) 		# 52449.87 ปอนด์สเตอร์ลิง

priceGermany <- EV$`PriceinGermany(€)` %>% mean(na.rm=T)
priceUK <- EV$`PriceinUK(£)` %>% mean(na.rm=T)

#แปลงหน่วยของ priceUK จากปอนด์สเตอร์ลิงเป็น priceGermany
priceUK <- priceUK*1.19 	#62415.34 ยูโร

priceUK - priceGermany 	    #4098.725 ยูโร
```
**Answer 4** : ราคาเฉลี่ยของรถในประเทศอังกฤษมีราคาสูงกว่าประเทศเยอรมัน 4,098.725 ยูโร

### 5.) ยิ่งความจุมากเท่าใด ความสามารถในการชาร์จพลังงานยิ่งเร็วขึ้นจริงไหม?
Code
```ruby
EV %>% select(`Battery EV (kWh)`,`FastChargeSpeed(km/h)`)
```
Result
```
# A tibble: 179 x 2
   `Battery EV (kWh)` `FastChargeSpeed(km/h)`
                <dbl>                   <dbl>
 1              200                       920
 2               90                       680
 3               83.7                     860
 4               83.7                     790
 5              200                       710
 6              110                      1380
 7               90                       830
 8               83.7                     840
 9               76                       790
10               85                       810
# ... with 169 more rows
```
**Answer 5** : ไม่จริง จากที่เปรียบเทียบข้อมูล บางรุ่นบรรจุbattery ได้เยอะแต่ความเร็วในการชาร์จไม่ได้เร็วขึ้น เพราะถ้าหากยิ่งความจุมาก ความเร็วในการชาร์จอาจจะลดลง

### 6.) โดยเฉลี่ยแล้วค่าพลังงานของรถยนต์ไฟฟ้าใช้ไปต่อชั่วโมง ใช้พลังงานเท่าไหร่?
Code
```ruby
EV$`Efficiency(Wh/km)` %>% mean(na.rm=T)
#or
mean(EV$`Efficiency(Wh/km)`,na.rm=T)
```
Result
```
194.419
```
**Answer 6** : โดยเฉลี่ยแล้วค่าพลังงานของรถยนต์ไฟฟ้าใช้ไป 194.419 Wh/km