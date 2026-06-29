CREATE FUNCTION "DBA"."KolorOpaski"( iID_GOSCIA INT )
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	DECLARE _wiek_goscia INT;
    DECLARE _status_goscia VARCHAR(20);
	SET _wiek_goscia=(
        SELECT datediff(year, GOSC.DATA_URODZENIA, CURRENT DATE)
        FROM GOSC
        WHERE GOSC.ID_GOSCIA=iID_GOSCIA
    );
    IF _wiek_goscia>=18 THEN 
        SET _status_goscia = 'Dorosly';
    ELSE 
        SET _status_goscia  ='Dziecko';
    END IF;
	RETURN _status_goscia;
END
