# Answer the question

## Define a question
1. ชุดข้อมูลนี้มีค่า NA มากน้อยแค่ไหน?
2. รถยี่ห้อใดที่มีความเร็วในการขับเร็วที่สุด
3. จงหาว่าชนิดของล้อที่ใช้ขับเคลื่อนมีกี่ชนิด และแต่ละแบบมีจำนวนเท่าใด
4. ราคาเฉลี่ยของรถในประเทศอังกฤษมีราคาสูงกว่าประเทศเยอรมันกี่ยูโร 
5. โดยเฉลี่ยแล้วค่าพลังงานของรถยนต์ไฟฟ้าใช้ไปต่อชั่วโมง ใช้พลังงานเท่าไหร่
6. ยิ่งความจุมากเท่าใด ความสามารถในการชาร์จพลังงานยิ่งเร็วขึ้นจริงไหม
7. กลุ่มรถยนต์ไฟฟ้าที่รูปแบบล้อที่ใช้ขับเคลื่อนรูปแบบไหน มีประสิทธิภาพที่ดีสุด

## Answer the question
### 1.) ชุดข้อมูลนี้มีค่า NA มากน้อยแค่ไหน?
Code
```R
summary(is.na(EV))
```
Result
```
    Name         Battery EV (kWh) Acceleration(sec) TopSpeed(km/h)  Range(km)       Efficiency(Wh/km)
 Mode :logical   Mode :logical    Mode :logical     Mode :logical   Mode :logical   Mode :logical    
 FALSE:179       FALSE:179        FALSE:179         FALSE:179       FALSE:179       FALSE:179        
                                                                                                     
 FastChargeSpeed(km/h)   Drive         NumberofSeats   PriceinGermany(€) PriceinUK(£)   
 Mode :logical         Mode :logical   Mode :logical   Mode :logical     Mode :logical  
 FALSE:174             FALSE:179       FALSE:179       FALSE:167         FALSE:135      
 TRUE :5                                               TRUE :12          TRUE :44  
```
**Answer 1** : พบว่าค่า NA(missing value) มีอยู่ในคอลัมน์ FastChargeSpeed(km/h) จำนวน 5 ข้อมูล, คอลัมน์ PriceinGermany(€) จำนวน 12 ข้อมูล, คอลัมน์ PriceinUK(£) จำนวน 44 ข้อมูล


### 2.) รถยี่ห้อใดที่มีความเร็วในการขับเร็วที่สุด?
Code
```R
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
**Answer 2** : รถยนตร์ไฟฟ้ารุ่น Tesla Roadster มีความเร็วที่สุด


### 3.) จงหาว่าชนิดของล้อที่ใช้ขับเคลื่อนมีกี่ชนิด และแต่ละแบบมีจำนวนเท่าใด?
Code
```R
EV$Drive <- as.factor(EV$Drive)
summary(EV$Drive)
```
Result
```
  All Wheel Drive Front Wheel Drive  Rear Wheel Drive 
               63                71                45 
```
**Answer 3** : ชนิดของล้อในการขับเคลื่อนแบ่งออกได้ 3 ประเภท ได้แก่
- All wheel drive มีรถที่ใช้ระเภทนี้อยู่ทั้งหมด 63 รุ่น 
- Rear wheel drive มีรถที่ใช้ประเภทนี้อยู่ทั้งหมด 71 รุ่น 
- Front wheel drive มีรถที่ใช้ระเภทนี้อยู่ทั้งหมด 45 รุ่น


### 4.) ราคาเฉลี่ยของรถในประเทศอังกฤษมีราคาสูงกว่าประเทศเยอรมันกี่ยูโร 
> (ถ้า 1 ปอนด์สเตอร์ลิง(£) = 1.19 ยูโร(€) //ใช้ข้อมูลที่ค้นหาในวันที่ 16 ตุลาคม 2021)
Code
```R
EV$`PriceinGermany(€)` %>% mean(na.rm=T) 	# 58316.62 ยูโร
EV$`PriceinUK(£)` %>% mean(na.rm=T) 		  # 52449.87 ปอนด์สเตอร์ลิง

priceGermany <- EV$`PriceinGermany(€)` %>% mean(na.rm=T)
priceUK <- EV$`PriceinUK(£)` %>% mean(na.rm=T)

#แปลงหน่วยของ priceUK จากปอนด์สเตอร์ลิงเป็น priceGermany
priceUK <- priceUK*1.19 	  #62415.34 ยูโร

priceUK - priceGermany 	    #4098.725 ยูโร
```
**Answer 4** : ราคาเฉลี่ยของรถในประเทศอังกฤษมีราคาสูงกว่าประเทศเยอรมันประมาณ 4,098.725 ยูโร


### 5.) โดยเฉลี่ยแล้วค่าพลังงานของรถยนต์ไฟฟ้าใช้ไปต่อชั่วโมง ใช้พลังงานเท่าไหร่?
Code
```R
EV$`Efficiency(Wh/km)` %>% mean(na.rm=T)
#or
mean(EV$`Efficiency(Wh/km)`,na.rm=T)
```
Result
```
194.419
```
**Answer 5** : โดยเฉลี่ยแล้วค่าพลังงานของรถยนต์ไฟฟ้าใช้ไป 194.419 Wh/km


### 6.) ยิ่งความจุมากเท่าใด ความสามารถในการชาร์จพลังงานยิ่งเร็วขึ้นจริงไหม?
Code
```R
EV %>% select(`Battery EV (kWh)`,`FastChargeSpeed(km/h)`)
#or poltting graph
EV %>% na.omit() %>% ggplot(aes(x=`Battery EV (kWh)`,y=`FastChargeSpeed(km/h)`)) + geom_point()
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
![Graph 1](graph1.png)

**Answer 6** : ไม่จริง จากที่เปรียบเทียบข้อมูลจะสังเกตเห็นได้ว่า รถยนต์ไฟฟ้าบางรุ่นบรรจุ battery ได้เยอะ แต่ความเร็วในการชาร์จไม่ได้เร็วขึ้น และเมื่อลองดูข้อมูลจากกราฟ จะพบว่ายิ่งความจุแบตเตอร์รี่มีขนาดมากเท่าไหร่ ก็จะใช้เวลาในการชาร์ตแบตนานขึ้นตามไปด้วย


### 7.) กลุ่มรถยนต์ไฟฟ้าที่รูปแบบล้อที่ใช้ขับเคลื่อนรูปแบบไหน มีประสิทธิภาพที่ดีสุด
> หาค่าเฉลี่ยของแต่ละกลุ่ม Drive นำมาจัดอันดับและเปรียบเทียบกับหลายๆ คอลัมน์ เพื่อให้แสดงเห็นถึงภาพรวมของรถยนต์ไฟฟ้าของแต่ละกลุ่มว่ามีจุดเด่น/จุดด้อย แตกต่างกันอย่างไรบ้าง
```R
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

```
Result
```
> EV %>% group_by(Drive) %>% select(Drive,`Battery EV (kWh)`) %>% 
+     summarise(`Battery EV (kWh)` = mean(`Battery EV (kWh)`)) %>% arrange(desc(`Battery EV (kWh)`))
# A tibble: 3 x 2
  Drive             `Battery EV (kWh)`
  <chr>                          <dbl>
1 All Wheel Drive                 84.3
2 Rear Wheel Drive                60.9
3 Front Wheel Drive               50.9
> EV %>% group_by(Drive) %>% select(Drive,`TopSpeed(km/h)`) %>% 
+   summarise(`TopSpeed(km/h)` = mean(`TopSpeed(km/h)`)) %>% arrange(desc(`TopSpeed(km/h)`))
# A tibble: 3 x 2
  Drive             `TopSpeed(km/h)`
  <chr>                        <dbl>
1 All Wheel Drive               212.
2 Rear Wheel Drive              171.
3 Front Wheel Drive             146.
> EV %>% group_by(Drive) %>% select(Drive,`Range(km)`) %>% 
+   summarise(`Range(km)` = mean(`Range(km)`)) %>% arrange(desc(`Range(km)`))
# A tibble: 3 x 2
  Drive             `Range(km)`
  <chr>                   <dbl>
1 All Wheel Drive          420.
2 Rear Wheel Drive         337.
3 Front Wheel Drive        262.
> EV %>% group_by(Drive) %>% select(Drive,`Efficiency(Wh/km)`) %>% 
+   summarise(`Efficiency(Wh/km)` = mean(`Efficiency(Wh/km)`)) %>% arrange(`Efficiency(Wh/km)`)
# A tibble: 3 x 2
  Drive             `Efficiency(Wh/km)`
  <chr>                           <dbl>
1 Rear Wheel Drive                 179.
2 Front Wheel Drive                197.
3 All Wheel Drive                  203.
> #เทียบจาก FastChargeSpeed
> EV %>% group_by(Drive) %>% select(Drive,`FastChargeSpeed(km/h)`) %>% 
+   summarise(`FastChargeSpeed(km/h)` = mean(`FastChargeSpeed(km/h)`,na.rm = T)) %>% arrange(desc(`FastChargeSpeed(km/h)`))
# A tibble: 3 x 2
  Drive             `FastChargeSpeed(km/h)`
  <chr>                               <dbl>
1 All Wheel Drive                      647.
2 Rear Wheel Drive                     533.
3 Front Wheel Drive                    297 
```
**Answer 7** : สรุปรวมเป็นตารางจัดอันดับได้ ดังนี้
|top|Battery EV (kWh)|TopSpeed(km/h)|Range(km)|Efficiency(Wh/km)|FastChargeSpeed(km/h)|
|1|All Wheel Drive |All Wheel Drive |All Wheel Drive |Rear Wheel Drive|All Wheel Drive|
|2|Rear Wheel Drive|Rear Wheel Drive|Rear Wheel Drive|Front Wheel Drive|Rear Wheel Drive|
|3|Front Wheel Drive |Front Wheel Drive|Front Wheel Drive|All Wheel Drive|Front Wheel Drive|

- เป็นไปได้ว่ารถยนต์ไฟฟ้ากลุ่มที่ขับเคลื่อนล้อแบบ All Wheel Drive อาจจะมีประสิทธิภาพดีที่สุด แต่ค่อนข้างใช้พลังงานเปลืองมากกว่ารถแบบอื่น
- ส่วนรถยนต์ไฟฟ้ากลุ่มที่ขับเคลื่อนล้อแบบ Rear Wheel Drive จะใช้พลังงานประหยัดกว่าแบบ All Wheel Drive
- รถยนต์ไฟฟ้ากลุ่มที่ขับเคลื่อนล้อแบบ Front Wheel Drive มีค่าเฉลี่ยโดยภาพรวมที่น้อยกว่าค่าเฉลี่ยรถแบบอื่น