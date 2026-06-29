DELIMITER $$

CREATE TRIGGER tr_blokada_podwojnej_rezerwacji_INSERT
BEFORE INSERT ON POBYT
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM POBYT
        WHERE NUMER_POKOJU = NEW.NUMER_POKOJU 
          -- Warunek nachodzenia na siebie dat:
          AND NEW.DATA_POCZATKU < DATA_KONCA
          AND NEW.DATA_KONCA > DATA_POCZATKU
    )
    THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Ten pokoj jest juz zarezerwowany w tym terminie';
    END IF;
END $$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER tr_blokada_podwojnej_rezerwacji_UPDATE
BEFORE UPDATE ON POBYT
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM POBYT
        WHERE NUMER_POKOJU = NEW.NUMER_POKOJU 
          AND ID_POBYTU <> NEW.ID_POBYTU
          AND NEW.DATA_POCZATKU < DATA_KONCA
          AND NEW.DATA_KONCA > DATA_POCZATKU
    )
    THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Ten pokoj jest juz zarezerwowany w tym terminie';
    END IF;
END $$

DELIMITER ;
