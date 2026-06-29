CREATE PROCEDURE "DBA"."RaportSprzatan"()
RESULT( NrPokoju INT, CzyDoSprzatania VARCHAR(30) )
BEGIN
    DECLARE _nr_pokoju VARCHAR(10);
    DECLARE _status_sprzatania VARCHAR(30);

    DECLARE kursor_pokoi DYNAMIC SCROLL CURSOR FOR 
        SELECT NUMER_POKOJU FROM POKOJ;

    OPEN kursor_pokoi;

    petla_raportu: LOOP
        FETCH NEXT kursor_pokoi INTO _nr_pokoju;
        IF SQLCODE <> 0 THEN LEAVE petla_raportu; END IF;
        SET _status_sprzatania = "DBA"."SprzataniePokoju"(_nr_pokoju);
        MESSAGE 'Pokoj: '||_nr_pokoju||' '||_status_sprzatania TO CLIENT; 
    END LOOP petla_raportu;

    CLOSE kursor_pokoi;
    DEALLOCATE kursor_pokoi;
END
