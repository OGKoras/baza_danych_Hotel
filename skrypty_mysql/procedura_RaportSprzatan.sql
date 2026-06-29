DELIMITER $$
CREATE PROCEDURE RaportSprzatan()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE nr_pokoju_var INT;
    DECLARE status_sprzatania_var VARCHAR(50);

    DECLARE kursor_pokoi CURSOR FOR SELECT NUMER_POKOJU FROM POKOJ;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    CREATE TEMPORARY TABLE IF NOT EXISTS WynikiRaportu (
        Log VARCHAR(255)
    );
    
    TRUNCATE TABLE WynikiRaportu;

    OPEN kursor_pokoi;

    petla_raportu: LOOP
        FETCH kursor_pokoi INTO nr_pokoju_var;
        
        IF done THEN 
            LEAVE petla_raportu; 
        END IF;

        SET status_sprzatania_var = SprzataniePokoju(nr_pokoju_var);

        INSERT INTO WynikiRaportu (Log)
        VALUES (CONCAT('Pokoj: ', nr_pokoju_var, ' Status: ', status_sprzatania_var));
        
    END LOOP petla_raportu;

    CLOSE kursor_pokoi;

    SELECT Log FROM WynikiRaportu;

    DROP TEMPORARY TABLE WynikiRaportu;
    
END $$

DELIMITER ;
