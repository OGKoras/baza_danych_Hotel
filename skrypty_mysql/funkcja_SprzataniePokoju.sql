DELIMITER $$

CREATE FUNCTION SprzataniePokoju(iID_POKOJU INT) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE czy_dzis_sprzatany INT;
    DECLARE typ_dnia_rezerwacji VARCHAR(20);

    SELECT COUNT(*) INTO czy_dzis_sprzatany
    FROM SPRZATANIE
    WHERE NUMER_POKOJU = iID_POKOJU 
      AND DATE(DATA_SPRZATANIA) = CURDATE();

    IF czy_dzis_sprzatany > 0 THEN
        RETURN 'Posprzatany';
    END IF;

    SELECT 
        CASE 
            WHEN DATA_POCZATKU = CURDATE() THEN 'PRZYJAZD'
            WHEN DATA_KONCA = CURDATE() THEN 'WYJAZD'
            ELSE 'W_TRAKCIE'
        END INTO typ_dnia_rezerwacji
    FROM POBYT
    WHERE NUMER_POKOJU = iID_POKOJU
      AND CURDATE() BETWEEN DATA_POCZATKU AND DATA_KONCA;

    IF typ_dnia_rezerwacji = 'PRZYJAZD' THEN
        RETURN 'Klient przyjezdza';
    ELSEIF typ_dnia_rezerwacji = 'WYJAZD' THEN
        RETURN 'Klient wyjezdza';
    ELSEIF typ_dnia_rezerwacji = 'W_TRAKCIE' THEN
        RETURN 'Posprzataj';
    ELSE
        RETURN 'Nie wymaga sprzatania';
    END IF;
END $$
DELIMITER ;
