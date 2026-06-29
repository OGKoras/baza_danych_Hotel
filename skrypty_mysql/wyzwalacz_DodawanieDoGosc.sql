DELIMITER $$

CREATE TRIGGER tr_dodawanie_do_gosc_INSERT
BEFORE INSERT ON GOSC
FOR EACH ROW
BEGIN
    DECLARE v_liczba_obecnych INT;
    DECLARE v_limit_miejsc INT;

    SELECT COUNT(*) INTO v_liczba_obecnych
    FROM GOSC
    WHERE ID_POBYTU = NEW.ID_POBYTU;

    SELECT p.LICZBA_MIEJSC INTO v_limit_miejsc
    FROM POKOJ p
    JOIN POBYT pb ON p.NUMER_POKOJU = pb.NUMER_POKOJU
    WHERE pb.ID_POBYTU = NEW.ID_POBYTU;

    IF v_liczba_obecnych >= v_limit_miejsc THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = ''Nie mozesz dodac wiecej gosci do tego pobytu';
    END IF;
END $$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER tr_dodawanie_do_gosc_UPDATE
BEFORE UPDATE ON GOSC
FOR EACH ROW
BEGIN
    DECLARE v_liczba_obecnych INT;
    DECLARE v_limit_miejsc INT;

    IF NEW.ID_POBYTU <> OLD.ID_POBYTU THEN
        
        SELECT COUNT(*) INTO v_liczba_obecnych
        FROM GOSC
        WHERE ID_POBYTU = NEW.ID_POBYTU;

        SELECT p.LICZBA_MIEJSC INTO v_limit_miejsc
        FROM POKOJ p
        JOIN POBYT pb ON p.NUMER_POKOJU = pb.NUMER_POKOJU
        WHERE pb.ID_POBYTU = NEW.ID_POBYTU;

        IF v_liczba_obecnych >= v_limit_miejsc THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = ''Nie mozesz dodac wiecej gosci do tego pobytu';
        END IF;
        
    END IF;
END $$

DELIMITER ;
