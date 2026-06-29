CREATE TRIGGER "tr_blokada_podwojnej_rezerwacji" BEFORE INSERT, UPDATE
ORDER 1 ON "DBA"."POBYT"
REFERENCING NEW AS new_name
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM POBYT
        WHERE NUMER_POKOJU = new_name.NUMER_POKOJU 
          AND ID_POBYTU <> new_name.ID_POBYTU
          AND new_name.DATA_POCZATKU < DATA_KONCA
          AND new_name.DATA_KONCA > DATA_POCZATKU
    )
    THEN
        RAISERROR 20001 'Ten pokoj jest juz zarezerwowany w tym terminie';
    END IF;
END
