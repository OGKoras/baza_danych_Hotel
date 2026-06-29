USE Hotel_mysql;

drop table if exists GOSC;

drop table if exists KLIENT;

drop table if exists POBYT;

drop table if exists POKOJ;

drop table if exists PRACOWNIK;

drop table if exists PRODUKTY_MINIBAROWE;

drop table if exists SPRZATANIE;

drop table if exists USLUGA;

drop table if exists WYKORZYSTANE_USLUGI;

drop table if exists ZUZYCIE;

/*==============================================================*/
/* Table: GOSC                                                  */
/*==============================================================*/
create table GOSC
(
   ID_GOSCIA            int not null,
   ID_POBYTU            int not null,
   NAZWISKO             char(50) not null,
   IMIE                 char(50) not null,
   DATA_URODZENIA       date not null,
   NR_DOKUMENTU         char(50) not null,
   primary key (ID_GOSCIA)
);

alter table GOSC comment 'Lista osob, ktore byly zameldowane w hotelu';

/*==============================================================*/
/* Table: KLIENT                                                */
/*==============================================================*/
create table KLIENT
(
   ID_KLIENTA           int not null,
   NAZWISKO             char(50) not null,
   IMIE                 char(50) not null,
   NR_DOKUMENTU         char(50) not null,
   DATA_URODZENIA       date not null,
   KOD_POCZTOWY         char(5),
   POCZTA               char(50),
   MIEJSCOWOSC          char(50),
   ULICA                char(50),
   NUMER_LOKALU         char(12),
   NUMER_TELEFONU       char(9),
   ADRES_EMAIL          char(60),
   primary key (ID_KLIENTA)
);

alter table KLIENT comment 'Lista osob, ktore zrobily rezerwacje w hotelu';

/*==============================================================*/
/* Table: POBYT                                                 */
/*==============================================================*/
create table POBYT
(
   ID_POBYTU            int not null,
   ID_KLIENTA           int not null,
   NUMER_POKOJU         int not null,
   DATA_POCZATKU        date not null,
   DATA_KONCA           date not null,
   LICZBA_OSOB          int not null,
   PLATNOSC             char(20),
   primary key (ID_POBYTU)
);

alter table POBYT comment 'Lista wszystkich pobyt w, kt re by y w hotelu';

/*==============================================================*/
/* Table: POKOJ                                                 */
/*==============================================================*/
create table POKOJ
(
   NUMER_POKOJU         int not null,
   LICZBA_MIEJSC        int not null,
   STANDARD             char(20),
   CENA_ZA_NOC          numeric(8,2) not null,
   PIETRO               int,
   primary key (NUMER_POKOJU)
);

alter table POKOJ comment 'Lista Pokoi';

/*==============================================================*/
/* Table: PRACOWNIK                                             */
/*==============================================================*/
create table PRACOWNIK
(
   ID_PRACOWNIKA        int not null,
   NAZWISKO             char(50) not null,
   IMIE                 char(50) not null,
   STANOWISKO           char(50) not null,
   DATA_ZATRUDNIENIA    date not null,
   TELEFON              char(9),
   EMAIL                char(50),
   WYNAGRODZENIE        numeric(8,2) not null,
   primary key (ID_PRACOWNIKA)
);

alter table PRACOWNIK comment 'Lista wszystkich pracownik w';

/*==============================================================*/
/* Table: PRODUKTY_MINIBAROWE                                   */
/*==============================================================*/
create table PRODUKTY_MINIBAROWE
(
   ID_PRODUKTU          int not null,
   NAZWA_PRODUKTU       char(50) not null,
   ALKOHOL              smallint not null,
   `POJEMNOSC(ML)`      int,
   primary key (ID_PRODUKTU)
);

alter table PRODUKTY_MINIBAROWE comment 'Lista produktow dostepnych w minibarku w kazdym pokoju';

/*==============================================================*/
/* Table: SPRZATANIE                                            */
/*==============================================================*/
create table SPRZATANIE
(
   ID_SPRZATANIA        int not null,
   ID_PRACOWNIKA        int not null,
   NUMER_POKOJU         int not null,
   DATA_SPRZATANIA      datetime not null,
   primary key (ID_SPRZATANIA)
);

/*==============================================================*/
/* Table: USLUGA                                                */
/*==============================================================*/
create table USLUGA
(
   ID_USLUGI            int not null,
   NAZWA_USLUGI         char(50) not null,
   CENA                 numeric(8,2) not null,
   JEDNOSTKA_ROZLICZENIOWA char(255) not null,
   primary key (ID_USLUGI)
);

alter table USLUGA comment 'Lista us ug jakie oferuje hotel';

/*==============================================================*/
/* Table: WYKORZYSTANE_USLUGI                                   */
/*==============================================================*/
create table WYKORZYSTANE_USLUGI
(
   ID_WYKORZYSTANIA     int not null,
   ID_POBYTU            int not null,
   ID_USLUGI            int not null,
   DATA_WYKORZYSTANIA   datetime not null,
   primary key (ID_WYKORZYSTANIA)
);

/*==============================================================*/
/* Table: ZUZYCIE                                               */
/*==============================================================*/
create table ZUZYCIE
(
   ID_ZUZYCIA           int not null,
   ID_POBYTU            int not null,
   ID_PRODUKTU          int not null,
   DATA_ZUZYCIA         datetime not null,
   primary key (ID_ZUZYCIA)
);

alter table GOSC add constraint FK_MELDUNEK foreign key (ID_POBYTU)
      references POBYT (ID_POBYTU) on delete restrict on update restrict;

alter table POBYT add constraint FK_ODBYWA_SIE_W foreign key (NUMER_POKOJU)
      references POKOJ (NUMER_POKOJU) on delete restrict on update restrict;

alter table POBYT add constraint FK_OPLACENIE foreign key (ID_KLIENTA)
      references KLIENT (ID_KLIENTA) on delete restrict on update restrict;

alter table SPRZATANIE add constraint FK_W foreign key (NUMER_POKOJU)
      references POKOJ (NUMER_POKOJU) on delete restrict on update restrict;

alter table SPRZATANIE add constraint FK_WYKONUJE foreign key (ID_PRACOWNIKA)
      references PRACOWNIK (ID_PRACOWNIKA) on delete restrict on update restrict;

alter table WYKORZYSTANE_USLUGI add constraint FK_JAKA foreign key (ID_USLUGI)
      references USLUGA (ID_USLUGI) on delete restrict on update restrict;

alter table WYKORZYSTANE_USLUGI add constraint FK_PRZEZ foreign key (ID_POBYTU)
      references POBYT (ID_POBYTU) on delete restrict on update restrict;

alter table ZUZYCIE add constraint `FK_JAKI PRODUKT` foreign key (ID_PRODUKTU)
      references PRODUKTY_MINIBAROWE (ID_PRODUKTU) on delete restrict on update restrict;
alter table ZUZYCIE add constraint FK_KTORY foreign key (ID_POBYTU)
      references POBYT (ID_POBYTU) on delete restrict on update restrict;

