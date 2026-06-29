CREATE USER 'Recepcjonista'@'%' IDENTIFIED BY 'Recepcjonista';
GRANT SELECT, INSERT, UPDATE ON GOSC TO 'Recepcjonista'@'%';
GRANT SELECT, INSERT, UPDATE ON KLIENT TO 'Recepcjonista'@'%';
GRANT SELECT, INSERT, UPDATE ON POBYT TO 'Recepcjonista'@'%';
GRANT SELECT ON POKOJ TO 'Recepcjonista'@'%';
GRANT SELECT ON DzisiejszyStatusPokoju TO 'Recepcjonista'@'%';
GRANT EXECUTE ON FUNCTION KolorOpaski TO 'Recepcjonista'@'%';
GRANT EXECUTE ON FUNCTION StanPokojuWDniu TO 'Recepcjonista'@'%';
GRANT EXECUTE ON PROCEDURE WymeldujKlienta TO 'Recepcjonista'@'%';
