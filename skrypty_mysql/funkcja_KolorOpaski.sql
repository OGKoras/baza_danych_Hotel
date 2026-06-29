DELIMITER $$

CREATE FUNCTION KolorOpaski(iID_GOSCIA INT) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE wiek_goscia INT;
    DECLARE status_goscia VARCHAR(20);

    SELECT TIMESTAMPDIFF(YEAR, DATA_URODZENIA, CURDATE()) INTO wiek_goscia
    FROM GOSC
    WHERE ID_GOSCIA = iID_GOSCIA;

    IF wiek_goscia >= 18 THEN 
        SET status_goscia = 'Dorosly';
    ELSE 
        SET status_goscia = 'Dziecko';
    END IF;

    RETURN status_goscia;
END $$

DELIMITER ;
