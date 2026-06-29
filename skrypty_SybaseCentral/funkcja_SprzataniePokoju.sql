CREATE FUNCTION "DBA"."SprzataniePokoju"( iID_POKOJU INT )
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE "StanPokoju" VARCHAR(50);
	DECLARE _czy_dzis_sprzatany INT;
    DECLARE _typ_dnia_rezerwacji VARCHAR(20);

    
    SET _czy_dzis_sprzatany=(
    SELECT count(*)
    FROM SPRZATANIE
    WHERE NUMER_POKOJU = iID_POKOJU 
    AND CAST(DATA_SPRZATANIA AS DATE) = CURRENT DATE
    );

    IF _czy_dzis_sprzatany > 0 THEN
        RETURN 'Posprzatany'
    END IF;
    
    SET _typ_dnia_rezerwacji=(
    SELECT 
        CASE 
            WHEN POBYT.DATA_POCZATKU = CURRENT DATE THEN 'PRZYJAZD'
            WHEN POBYT.DATA_KONCA = CURRENT DATE THEN 'WYJAZD'
            ELSE 'W_TRAKCIE'
        END 
    FROM POBYT
    WHERE NUMER_POKOJU = iID_POKOJU
    AND CURRENT DATE BETWEEN POBYT.DATA_POCZATKU AND POBYT.DATA_KONCA
    );

    IF _typ_dnia_rezerwacji = 'PRZYJAZD' THEN
        RETURN 'Klient przyjezdza';
    ELSEIF _typ_dnia_rezerwacji = 'WYJAZD' THEN
        RETURN 'Klient wyjezdza';
    ELSEIF _typ_dnia_rezerwacji = 'W_TRAKCIE' THEN
        RETURN 'Posprzataj';
    ELSE
        RETURN 'Nie wymaga sprzatania';
    END IF;
END
