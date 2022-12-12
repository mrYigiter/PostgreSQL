CREATE TABLE ogrenciler 
(  
  id int, 
  isim varchar(50), 
  sehir varchar(50), 
  puan int,
  bolum varchar(20)
);

INSERT INTO ogrenciler VALUES(100, 'Ahmet Ümit', 'İstanbul', 546, 'Bilgisayar Müh.');
INSERT INTO ogrenciler VALUES(101, 'R.Nuri Güntekin', 'Antalya', 486, 'İşletme');
INSERT INTO ogrenciler VALUES(102, 'S.Faik Abasıyanık', 'Bursa', 554, 'Bilgisayar Müh.');
INSERT INTO ogrenciler VALUES(103, 'Yaşar Kemal', 'İstanbul', 501, 'Matematik');
INSERT INTO ogrenciler VALUES(104, 'Halide E. Adıvar', 'İzmir', 473, 'Psikoloji');
INSERT INTO ogrenciler VALUES(105, 'Nazan Bekiroğlu', 'İzmir', 432, 'Edebiyat');
INSERT INTO ogrenciler VALUES(106, 'Peyami Safa', 'Antalya', 535, 'Bilgisayar Müh.');
INSERT INTO ogrenciler VALUES(107, 'Sabahattin Ali', 'İstanbul', 492, 'Matematik');

CREATE TABLE bolumler 
(  
  bolum_id int, 
  bolum varchar(20),
  taban_puanı int,
  kampus varchar(20)
);

INSERT INTO bolumler VALUES(5001, 'Bilgisayar Müh.', 521,'Kuzey');
INSERT INTO bolumler VALUES(5002, 'Matematik', 455,'Güney');
INSERT INTO bolumler VALUES(5003, 'Psikoloji', 440,'Hisar');
INSERT INTO bolumler VALUES(5004, 'İşletme', 465,'Hisar');
INSERT INTO bolumler VALUES(5005, 'Edebiyat', 420,'Kuzey');

--1)Puanı, taban puanı en yüksek olan bölümün puanından yüksek olan öğrencilerin isim ve sehirlerini 
--listeleyiniz.
select isim,sehir,puan from ogrenciler where puan > (select max(taban_puanı) from bolumler)

--2)Taban puanı 460 dan az olan bölümlerdeki öğrencilerin isimlerini ve bölümlerini listeleyiniz.
select isim,bolum from ogrenciler where bolum in (select bolum from bolumler where taban_puanı<460) 

--3)İstanbulda yaşayan öğrencilerin bölümlerini ve taban puanlarını listeleyiniz.
select bolum,taban_puanı from bolumler where bolum in(select bolum from ogrenciler where sehir='İstanbul');

--4)Kuzey kampüsündeki bölümlerde okuyan öğrencilerin isimlerini, bölümlerini ve puanlarını listeleyiniz.
SELECT isim,bolum,puan from ogrenciler where bolum in (select bolum from bolumler where kampus='Kuzey');

--5)Puanı taban puanlarının ortalamasından yüksek olan öğrencilerin isim ve puanlarını listeleyiniz.
select isim,puan from ogrenciler where puan > (select avg(taban_puanı) from bolumler );


--6) Taban puanı öğrencilerin puan ortalamasından düşük olan
 --  ve hisar kampüsünde olan bölümleri listeleyiniz.
 select bolum,kampus from bolumler where taban_puanı <(select avg(puan) from ogrenciler) and kampus ='Hisar';

--7)Hisar veya Güney kampüsünde okuyan öğrencilerin isimlerini listeleyiniz.
select isim from ogrenciler where bolum in (select bolum from bolumler  where kampus in('Hisar','Güney') )

--8)Bölüm isimlerini, kampüslerini ve 
--her bölümde okuyan öğrencilerin en yüksek puanlarını listeleyiniz.
select bolum,kampus,(select max(puan) from ogrenciler where ogrenciler.bolum=bolumler.bolum ) from bolumler;
select bolum,max(puan) from ogrenciler group by bolum; -- kampu olduğu için bu şekilde olmaz
--9) Her bölümün ismini ve 
--bölümde okuyan öğrencilerin kaç farklı şehirden geldiğini listeleyiniz. 
select bolum,(select count(distinct(sehir) from ogrenciler o where b.bolum =b. bolum) from bolumler b;
			  
			  --10)Puanı 500 den büyük olan öğrencilerin bölümlerinin adını ve kampüslerini listeleyiniz.
select bolum,kampus from bolumler where in (select bolum from ogrenciler where puan >500);

			  
--SUBQUERY--NESTEDQUERY--
--altsorgu--içiçesorgu--

--1)Puanı, taban puanı en yüksek olan bölümün puanından yüksek olan öğrencilerin isim ve sehirlerini 
--listeleyiniz.
SELECT MAX(taban_puanı) FROM bolumler--521
SELECT isim, sehir 
FROM ogrenciler 
WHERE puan > 521

--subquery ile
SELECT isim, sehir 
FROM ogrenciler 
WHERE puan > (SELECT MAX(taban_puanı) 
			  FROM bolumler)

--2)Taban puanı 460 dan az olan bölümlerdeki öğrencilerin isimlerini 
--ve bölümlerini listeleyiniz.

SELECT isim, bolum 
FROM ogrenciler
WHERE bolum IN (SELECT bolum 
			   FROM bolumler
			   WHERE taban_puanı<460) 

--3)İstanbulda yaşayan öğrencilerin bölümlerini ve 
--taban puanlarını listeleyiniz.

SELECT bolum, taban_puanı
FROM bolumler
WHERE bolum IN (SELECT bolum
			   FROM ogrenciler
			   WHERE sehir='İstanbul')

--4)Kuzey kampüsündeki bölümlerde okuyan öğrencilerin isimlerini, bölümlerini ve puanlarını listeleyiniz.

SELECT isim, bolum, puan
FROM ogrenciler
WHERE bolum IN (SELECT bolum
			   FROM bolumler
			   WHERE kampus='Kuzey')

--5)Puanı taban puanlarının ortalamasından yüksek olan öğrencilerin isim ve puanlarını 
--listeleyiniz.//max,min ödev

SELECT isim, puan
FROM ogrenciler
WHERE puan > (SELECT AVG(taban_puanı)
			 FROM bolumler) 

--6) Taban puanı öğrencilerin puan ortalamasından düşük olan
--ve hisar kampüsünde olan bölümleri listeleyiniz.

SELECT * 
FROM bolumler
WHERE taban_puanı < (SELECT AVG(puan)
					FROM ogrenciler)
AND kampus='Hisar'

--7)Hisar veya Güney kampüsünde okuyan öğrencilerin isimlerini listeleyiniz.

SELECT isim
FROM ogrenciler
WHERE bolum IN (SELECT bolum
			   FROM bolumler
			   WHERE kampus='Hisar' OR kampus='Güney')

--8)Bölüm isimlerini, kampüslerini ve 
--her bölümde okuyan öğrencilerin en yüksek puanlarını listeleyiniz.(ilişkili-corralated)
SELECT bolum, kampus, (SELECT MAX(puan)
					  FROM ogrenciler o 
					  WHERE o.bolum=b.bolum) max_puan
FROM bolumler b

--9) Her bölümün ismini ve 
--bölümde okuyan öğrencilerin kaç farklı şehirden geldiğini listeleyiniz.  

SELECT bolum, (SELECT COUNT(DISTINCT(sehir))
			  FROM ogrenciler o
			  WHERE o.bolum=b.bolum)
FROM bolumler b

--10)Puanı 500 den büyük olan öğrencilerin bölümlerinin adını ve kampüslerini listeleyiniz.

SELECT bolum, kampus
FROM bolumler
WHERE bolum IN (SELECT bolum 
			   FROM ogrenciler
			   WHERE puan > 500)
			  
			  

