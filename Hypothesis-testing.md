#Hypothesis testing

คือ วิธีการทางสถิติที่ใช้ในการพิสูจน์ว่า สมมติฐานที่ตั้งนั้นเป็นจริงหรือไม่
โดยความเป็นไปได้ของสมมติฐานตามปกติจะมี 2 ข้อ ได้แก่
- Ho : null hypothesis : สมมติฐานที่เหตุการณ์เป็นปกติ
- Ha : alternate hypothesis : สมมติฐานที่เป็นเหตุการณ์ที่ไม่ปกติ/ต่างออกไป หรือ สมมติฐานของสิ่งที่เราสนใจอยากรู้

การตั้งสมมติฐานเช่นนี้จะต้องผ่านการพิสูจน์ว่าข้อใดเป็นจริง

-----

### Hypothesis Question##

ข้อมูลของเราเป็นข้อมูลรถอิเล็กทรอนิกส์ความเร็วอันดับต้นๆ
ลูกค้าอยากทราบว่าการที่ความเร็วมากจะส่งผลต่อราคาที่แพงกว่าปกติจริงหรือไม่?
โดยจากการเก็บข้อมูลจากผู้ผลิตรถอิเล็กทรอนิกส์ทั่วโลก พบว่า ราคาเฉลี่ยในประเทศอังกฤษอยู๋ที่ £44,000
กำหนดค่า alpha เท่ากับ 0.05


**1. ตั้งสมมติฐาน**
เนื่องจากเราต้องการรู้ว่า ราคารถมากกว่า £44,000 จริงหรือไม่ ได้สมมติฐานดังนี้
```
#u0 <= 44000
#u0 > 44000
```

**2. หาค่าตัวแปรต่างๆ** ได้แก่ u0/p0, xbar/pbar, n, sd/sigma, alpha

```
## Find value of variables
u <- 44000
xbar <- EV$`PriceinUK(£)` %>% mean(na.rm = TRUE)
sd <- EV$`PriceinUK(£)` %>% sd(na.rm = TRUE)
n <- EV %>% count() %>% as.numeric()
df <- n-1
alpha <- 0.05

```
Result: 
- u = 44000
- xbar = 52449.87
- sd = 28198.94
- n = 179
- df(degree of freedom) = 178
- alpha = 0.05

**3. หาค่า test statistics**
หาค่า t เนื่องจากเป็น สมมติฐานของหนึ่งประชากรและไม่รู้ค่า sigma

```
##Find test statistics
t <- (xbar-u)/(sd/sqrt(n)) %>% as.numeric()
```

**4. หาค่า p-value**
หาค่า p-value จากค่า t โดยใช้ฟังก์ชั่น `pt(ค่าq,degree of freedom,lower.tail = TRUE)`

```
##Find p-value
pvalue <- 1-pt(t,df,lower.tail = TRUE)
```
Result : p-value มีค่าเท่ากับ 4.4777722e-05 หรือหากให้เข้าใจง่าย จะเท่ากับ 0.0000448


**5. เทียบค่า p-value กับ alpha**
มีทั้งหมด 2 วิธีได้แก่

- เทียบด้วย p-value กับค่า alpha
```
#First method
if(pvalue>alpha){
  print("Not reject Ho.")
}else{
  print("Reject Ho.")
}
```

- เทียบด้วย critical value (เทียบค่า t กับค่า t ของ alpha)
โดยหาค่า t ของ alpha โดยใช้ฟังก์ชั่น `qt(p,df,lower.tail = TRUE)`
```
#Second method
talpha <- qt(1-alpha,df,lower.tail = TRUE)
#comparing talpha vs t
if(talpha<t){
  print("Not reject Ho.")
}else{
  print("Reject Ho.")
}

```

**6. สรุปผลสมมติฐาน**
จากการพิสูจน์ ผลลัพธ์ที่ออกมาคือ "Reject Ho." หมายความว่า Ho เป็นเท็จและ Ha เป็นจริง
สรุปผลได้ว่า การที่ความเร็วของรถสูง ส่งผลให้ราคาของรถแพงขึ้นตามไปด้วย


