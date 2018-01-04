
-- MS SQL Server - 1.14 min Standard Join - done
Select k.name, k.vorname, k.kreditorennr, k.land, 
b.artbez, b.betraggesamt, b.menge, b.mwstgesamt, b.rabatmenge, 
l.abholstationen, l.dauerdurchschnitt, l.unternehmen,
s.leitername, s.leitervorname
From Kunden k 
Join Bestellung b On (k.kunnr = b.kunnr)
Join Lieferdienst l On (b.bestellnr = l.bestellnr)
Join Standorte s On (l.liefernr = s.liefernr)
Order by k.name; 

-- MS SQL Server 2 - 1.12 min Standard Join mit Berechnungen -done
Use Testdatenbank
Select k.name, k.vorname, k.kreditorennr, k.land, 
b.artbez, b.betraggesamt, b.menge, b.mwstgesamt, b.rabatmenge, (b.menge*b.betraggesamt) As SumRand, (b.betraggesamt * b.mwstgesamt - ((b.menge - b.rabatmenge)/100) * b.betraggesamt) As test,
l.abholstationen, l.dauerdurchschnitt, l.unternehmen,
s.leitername, s.leitervorname
From Kunden k 
Join Bestellung b On (k.kunnr = b.kunnr)
Join Lieferdienst l On (b.bestellnr = l.bestellnr)
Join Standorte s On (l.liefernr = s.liefernr)
Order by k.name; 

-- SAP Hana 
Select k.name, k.vorname, k.kreditorennr, k.land, 
b.artbez, b.betraggesamt, b.menge, b.mwstgesamt, b.rabattmenge, 
l.abholstationen, l.dauerdurchschnitt, l.unternehmen,
s.leitername, s.leitervorname
From "XSA_ADMIN".Kunden k 
Inner Join "XSA_ADMIN".Bestellung b On (k.kunnr = b.kunnr)
Inner Join "XSA_ADMIN".Lieferdienst l On (b.bestellnr = l.bestellnr)
Inner Join "XSA_ADMIN".Standorte s On (l.liefernr = s.liefernr)
Order by k.name; 

-- durchschnittlicher Lieferdienstpreis, Bestellpreis, Mitarbeiterzahl
Use Testdatenbank
SELECT AVG (Lieferdienst.Preis) AS AVGLief, AVG (Bestellung.Preis) AS AVGBestell, AVG (Standorte.Mitarbeiteranzahl) AS AVGMit 
FROM Lieferdienst, Bestellung, Standorte
WHERE Standorte.Liefernr = Lieferdienst.Liefernr AND Bestellung.Bestellnr = Lieferdienst.Bestellnr
GROUP BY AVGLief Desc;

--summe Fuhrparkgröße der bestellungen vom "bestimmtes datum"
SELECT sum(s.fuhrparkgroeße) AS SummeFuhrparkgröße, b.Datum
FROM Bestellung b 
Join Lieferdienst l ON (b.Bestellnr = l.Bestellnr)
Join Standorte s ON (l.Liefernr = s.Liefernr)
Where b.Datum = 'dd.mm.yyyy'
GROUP BY SummeFuhrparkgröße Desc



--durchschnittlicher RabattKunde für bestimmten kunden und die liefernummern der bestellungen
Select AVG (RabattKunde) AS DurchschnittlicherRabattKunde, k.Name, l.Liefernr
FROM Kunde k Join Bestellung b ON (k.Kunnr = b.Kunnr)
JOIN Lieferdienst l ON (b.Bestellnr = l.Bestellnr)
JOIN Standorte s ON (l.Liefernr = s.Liefernr)
Where k.Kunnr = xxxxx 
GROUP BY DurchschnittlicherRabattKunde; 




--durchschnittliche anzahl der bestellungen pro lieferant.
Select AVG (l.Bestellnr) As AVGBestellProLief, l.Unternehmen
FROM Bestellung b 
JOIN Lieferdienst l ON(b.Bestellnr = l.Bestellnr)
Group BY AVGBestellProLief 

-- SummeBetragGesamt, Rechnung
SELECT "Bestellnr" ,SUM("BetragGesamt")AS "SummeBetragGesamt",(SELECT SUM("MaxLieferMenge") FROM "XSA_ADMIN"."Lieferdienst") AS "Rechnung" 
FROM "XSA_ADMIN"."Bestellungen"
WHERE "Bestellnr" IN (SELECT "Bestellnr" FROM "XSA_ADMIN"."Bestellungen")
GROUP BY "Bestellnr"
ORDER BY "Rechnung" desc;




-- für spätere Tests!
DECLARE @t1 DATETIME;
DECLARE @t2 DATETIME;

SET @t1 = GETDATE();
SELECT /* query one */ 1 ;
SET @t2 = GETDATE();
SELECT DATEDIFF(millisecond,@t1,@t2) AS elapsed_ms;

SET @t1 = GETDATE();
SELECT /* query two */ 2 ;
SET @t2 = GETDATE();
SELECT DATEDIFF(millisecond,@t1,@t2) AS elapsed_ms;