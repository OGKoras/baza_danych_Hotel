DELIMITER $$

CREATE PROCEDURE WymeldujKlienta(IN pPOBYT INT)
BEGIN
    DECLARE suma_nocleg DECIMAL(10,2);
    DECLARE suma_uslugi DECIMAL(10,2);
    DECLARE suma_calkowita DECIMAL(10,2);

    SELECT 
        CASE 
            WHEN DATEDIFF(pb.DATA_KONCA, pb.DATA_POCZATKU) = 0 THEN pk.CENA_ZA_NOC
            ELSE DATEDIFF(pb.DATA_KONCA, pb.DATA_POCZATKU) * pk.CENA_ZA_NOC
        END INTO suma_nocleg
    FROM POBYT pb
    JOIN POKOJ pk ON pb.NUMER_POKOJU = pk.NUMER_POKOJU
    WHERE pb.ID_POBYTU = pPOBYT;

    SELECT 
        COALESCE(SUM(u.CENA), 0) INTO suma_uslugi
    FROM WYKORZYSTANE_USLUGI wu
    JOIN USLUGA u ON wu.ID_USLUGI = u.ID_USLUGI
    WHERE wu.ID_POBYTU = pPOBYT;

    SET suma_calkowita = suma_nocleg + suma_uslugi;

    SELECT 
        pb.ID_POBYTU, 
        k.NAZWISKO, 
        k.IMIE, 
        pb.NUMER_POKOJU,
        suma_nocleg AS Koszt_Noclegu, 
        suma_uslugi AS Koszt_Uslug, 
        suma_calkowita AS Do_Zaplaty, 
        pb.PLATNOSC
    FROM POBYT pb 
    JOIN KLIENT k ON pb.ID_KLIENTA = k.ID_KLIENTA
    WHERE pb.ID_POBYTU = pPOBYT;
END $$

DELIMITER ;
