use papyrus


--1
SELECT NUMCOM from stg02.ENTCOM where NUMFOU = '9120'

--2
SELECT NUMFOU,COUNT (numcom) as 'nombre de commande' from stg02.ENTCOM GROUP BY NUMFOU

--3
SELECT COUNT (numcom) as 'nombre de commande', COUNT (DISTINCT numfou) as 'nombre de fournisseur' from stg02.ENTCOM 

--4
SELECT codart,libart,stkphy,stkale,QTEANN from stg02.PRODUIT WHERE STKPHY <= STKALE and QTEANN < 1000 

--5
SELECT NOMFOU, SUBSTRING (posfou,1,2) as 'DEP fournisseur' from stg02.FOURNIS where POSFOU LIKE'75%' or POSFOU LIKE '78%' or POSFOU LIKE'92%' or POSFOU LIKE '77%' ORDER BY POSFOU DESC, NOMFOU
--ou
SELECT nomfou, substring(posfou,1,2) as 'Départements' from stg02.fournis where substring(posfou,1,2) in ('75', '78', '92', '77') order by posfou desc, nomfou

--6
select datcom from stg02.entcom
SELECT NUMCOM, DATCOM from stg02.ENTCOM WHERE MONTH(DATCOM) = 3 or MONTH(DATCOM) = 4

--7
SELECT NUMCOM,DATCOM from stg02.ENTCOM WHERE OBSCOM is not null and YEAR(DATCOM)=YEAR(GETDATE()) 

--8
SELECT NUMCOM, SUM (QTECDE * CAST(PRIUNI as money)) as TOTAL from stg02.LIGCOM  GROUP BY NUMCOM ORDER BY TOTAL DESC

--9
SELECT NUMCOM, SUM (QTECDE  * PRIUNI) as 'TOTAL' 
from stg02.LIGCOM 
WHERE QTECDE < 1000
GROUP BY NUMCOM 
HAVING SUM (QTECDE  * PRIUNI)>10000  

--10
SELECT nomfou,DATCOM,NUMCOM from stg02.FOURNIS,stg02.ENTCOM WHERE entcom.NUMFOU = fournis.NUMFOU

--11
SELECT entcom.NUMCOM,nomfou,libart,SUM (QTECDE * CAST(PRIUNI as money)) as 'Sous total'  
FROM stg02.ENTCOM,stg02.FOURNIS,stg02.LIGCOM,stg02.PRODUIT
WHERE OBSCOM = 'commande urgente' and entcom.NUMFOU = FOURNIS.NUMFOU and ENTCOM.NUMCOM = LIGCOM.NUMCOM and produit.CODART = LIGCOM.CODART
GROUP BY ENTCOM.NUMCOM,NOMFOU,LIBART

--12
SELECT nomfou
FROM stg02.ENTCOM,STG02.FOURNIS,stg02.LIGCOM
WHERE entcom.NUMFOU = FOURNIS.NUMFOU and ENTCOM.NUMCOM = LIGCOM.NUMCOM  and QTELIV >= 1
GROUP BY NOMFOU


--13
SELECT numcom,datcom 
FROM stg02.ENTCOM
WHERE numfou in ENTCOM.NUMCOM is 5
group by NUMCOM,DATCOM

--OU
select numcom, datcom from stg02.entcom where numfou = 
(select numfou from stg02.entcom where numcom = 5)

--14
SELECT libart,prix1
FROM stg02.VENTE,stg02.PRODUIT
WHERE produit.CODART = vente.CODART and STKPHY > 0 and PRIX1 < (
select min(prix1) from stg02.VENTE,stg02.PRODUIT 
where produit.CODART = vente.CODART and LIBART  Like 'R%' )
GROUP BY LIBART,PRIX1

--15
SELECT LIBART,fournis.NUMFOU
from stg02.PRODUIT,stg02.FOURNIS, stg02.VENTE
WHERE FOURNIS.NUMFOU = VENTE.NUMFOU and vente.CODART = PRODUIT.CODART and STKPHY <= (
SELECT SUM (STKALE * 1.5) 
from stg02.PRODUIT
WHERE STKALE > 0 and STKPHY > 0)
ORDER BY LIBART,fournis.NUMFOU

--16
SELECT LIBART,fournis.NUMFOU
from stg02.PRODUIT,stg02.FOURNIS, stg02.VENTE
WHERE FOURNIS.NUMFOU = VENTE.NUMFOU and vente.CODART = PRODUIT.CODART and STKPHY <= (
SELECT SUM (STKALE * 1.5) 
from stg02.PRODUIT
WHERE STKALE > 0 and STKPHY > 0 and DELLIV < 30)
ORDER BY LIBART,fournis.NUMFOU

--17
SELECT numfou, SUM (STKPHY) as STOCK
FROM stg02.VENTE,stg02.PRODUIT
WHERE vente.CODART = produit.CODART
GROUP BY NUMFOU
ORDER BY STOCK DESC

--18
SELECT LIBART, SUM (QTECDE) as Quantite 
FROM stg02.PRODUIT,stg02.LIGCOM
WHERE PRODUIT.CODART = LIGCOM.CODART
GROUP BY LIBART, QTEANN
HAVING (QTEANN * 0.90) < SUM (QTECDE)

--19
SELECT NUMFOU, SUM (QTECDE * PRIUNI *1.20) as prixttc
FROM stg02.LIGCOM,stg02.ENTCOM
WHERE ENTCOM.NUMCOM = LIGCOM.NUMCOM
GROUP BY NUMFOU

USE papyrus_test
go

-- LES BESOINS DE MAJ

--1

UPDATE stg02.VENTE
SET PRIX1 = PRIX1*1.04, PRIX2 = PRIX2 *1.02
WHERE NUMFOU = 9180

--2
UPDATE stg02.VENTE
SET PRIX2=PRIX1
WHERE PRIX2 is null 

--3
UPDATE stg02.ENTCOM 
SET OBSCOM = '*****'
FROM stg02.entcom
JOIN  stg02.FOURNIS
ON ENTCOM.NUMFOU = FOURNIS.NUMFOU 
WHERE SATISF <5


--4

DELETE from stg02.VENTE
FROM stg02.VENTE
JOIN stg02.PRODUIT
on PRODUIT.CODART = VENTE.CODART
WHERE produit.CODART = 'l110'

DELETE from stg02.LIGCOM
FROM stg02.LIGCOM
JOIN stg02.PRODUIT
on PRODUIT.CODART = ligcom.CODART
WHERE produit.CODART = 'l110'

DELETE from stg02.produit
FROM stg02.produit
WHERE produit.CODART = 'l110'

--5

DELETE FROM stg02.ENTCOM
FROM STG02.ENTCOM
JOIN STG02.LIGCOM
ON LIGCOM.NUMCOM = ENTCOM.NUMCOM
WHERE ENTCOM.NUMCOM in (SELECT LIGCOM.NUMCOM FROM stg02.LIGCOM,STG02.ENTCOM WHERE ENTCOM.NUMCOM <> LIGCOM.NUMCOM)


https://github.com/KatSou/Fichier-afpa/blob/master/CAS%20PAPYRUS/Exercice%20sur%20papyrus.sql