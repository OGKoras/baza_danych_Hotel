CREATE DATABASE Hotel_mysql;

USE

if exists(select 1 from sys.sysforeignkey where role='FK_GOSC_MELDUNEK_POBYT') then
    alter table GOSC
       delete foreign key FK_GOSC_MELDUNEK_POBYT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_POBYT_ODBYWA_SI_POKOJ') then
    alter table POBYT
       delete foreign key FK_POBYT_ODBYWA_SI_POKOJ
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_POBYT_OPLACENIE_KLIENT') then
    alter table POBYT
       delete foreign key FK_POBYT_OPLACENIE_KLIENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SPRZATAN_W_POKOJ') then
    alter table SPRZATANIE
       delete foreign key FK_SPRZATAN_W_POKOJ
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SPRZATAN_WYKONUJE_PRACOWNI') then
    alter table SPRZATANIE
       delete foreign key FK_SPRZATAN_WYKONUJE_PRACOWNI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_WYKORZYS_JAKA_USLUGA') then
    alter table WYKORZYSTANE_USLUGI
       delete foreign key FK_WYKORZYS_JAKA_USLUGA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_WYKORZYS_PRZEZ_POBYT') then
    alter table WYKORZYSTANE_USLUGI
       delete foreign key FK_WYKORZYS_PRZEZ_POBYT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ZUZYCIE_JAKI PROD_PRODUKTY') then
    alter table ZUZYCIE
       delete foreign key "FK_ZUZYCIE_JAKI PROD_PRODUKTY"
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ZUZYCIE_KTORY_POBYT') then
    alter table ZUZYCIE
       delete foreign key FK_ZUZYCIE_KTORY_POBYT
end if;

drop index if exists GOSC.MELDUNEK_FK;

drop index if exists GOSC.GOSC_PK;

drop table if exists GOSC;

drop index if exists KLIENT.KLIENT_PK;

drop table if exists KLIENT;

drop index if exists POBYT.OPLACENIE_FK;

drop index if exists POBYT.ODBYWA_SIE_W_FK;

drop index if exists POBYT.POBYT_PK;

drop table if exists POBYT;

drop index if exists POKOJ.POKOJ_PK;

drop table if exists POKOJ;

drop index if exists PRACOWNIK.PRACOWNIK_PK;

drop table if exists PRACOWNIK;

drop index if exists PRODUKTY_MINIBAROWE.PRODUKTY_MINIBAROWE_PK;

drop table if exists PRODUKTY_MINIBAROWE;

drop index if exists SPRZATANIE.SPRZATANIE2_FK;

drop index if exists SPRZATANIE.SPRZATANIE_FK;

drop index if exists SPRZATANIE.SPRZATANIE_PK;

drop table if exists SPRZATANIE;

drop index if exists USLUGA.USLUGA_PK;

drop table if exists USLUGA;

drop index if exists WYKORZYSTANE_USLUGI.WYKORZYSTANE_USLUGI2_FK;

drop index if exists WYKORZYSTANE_USLUGI.WYKORZYSTANE_USLUGI_FK;

drop index if exists WYKORZYSTANE_USLUGI.WYKORZYSTANE_USLUGI_PK;

drop table if exists WYKORZYSTANE_USLUGI;

drop index if exists ZUZYCIE.ZUZYCIE2_FK;

drop index if exists ZUZYCIE.ZUZYCIE_FK;

drop index if exists ZUZYCIE.ZUZYCIE_PK;

drop table if exists ZUZYCIE;

/*==============================================================*/
/* Table: GOSC                                                  */
/*==============================================================*/
create table GOSC 
(
   ID_GOSCIA            integer                        not null,
   ID_POBYTU            integer                        not null,
   NAZWISKO             char(50)                       not null,
   IMIE                 char(50)                       not null,
   DATA_URODZENIA       date                           not null,
   NR_DOKUMENTU         char(50)                       not null,
   constraint PK_GOSC primary key (ID_GOSCIA)
);

comment on table GOSC is 
'Lista osob, ktore byly zameldowane w hotelu';

/*==============================================================*/
/* Index: GOSC_PK                                               */
/*==============================================================*/
create unique index GOSC_PK on GOSC (
ID_GOSCIA ASC
);

/*==============================================================*/
/* Index: MELDUNEK_FK                                           */
/*==============================================================*/
create index MELDUNEK_FK on GOSC (
ID_POBYTU ASC
);

/*==============================================================*/
/* Table: KLIENT                                                */
/*==============================================================*/
create table KLIENT 
(
   ID_KLIENTA           integer                        not null,
   NAZWISKO             char(50)                       not null,
   IMIE                 A50                            not null,
   NR_DOKUMENTU         char(50)                       not null,
   DATA_URODZENIA       date                           not null,
   KOD_POCZTOWY         char(5)                        null,
   POCZTA               char(50)                       null,
   MIEJSCOWOSC          char(50)                       null,
   ULICA                char(50)                       null,
   NUMER_LOKALU         char(12)                       null,
   NUMER_TELEFONU       A9                             null,
   ADRES_EMAIL          A60                            null,
   constraint PK_KLIENT primary key (ID_KLIENTA)
);

comment on table KLIENT is 
'Lista osob, ktore zrobily rezerwacje w hotelu';

/*==============================================================*/
/* Index: KLIENT_PK                                             */
/*==============================================================*/
create unique index KLIENT_PK on KLIENT (
ID_KLIENTA ASC
);

/*==============================================================*/
/* Table: POBYT                                                 */
/*==============================================================*/
create table POBYT 
(
   ID_POBYTU            integer                        not null,
   ID_KLIENTA           integer                        not null,
   NUMER_POKOJU         integer                        not null,
   DATA_POCZATKU        date                           not null,
   DATA_KONCA           date                           not null,
   LICZBA_OSOB          integer                        not null,
   PLATNOSC             char(20)                       null,
   constraint PK_POBYT primary key (ID_POBYTU)
);

comment on table POBYT is 
'Lista wszystkich pobyt w, kt re by y w hotelu';

/*==============================================================*/
/* Index: POBYT_PK                                              */
/*==============================================================*/
create unique index POBYT_PK on POBYT (
ID_POBYTU ASC
);

/*==============================================================*/
/* Index: ODBYWA_SIE_W_FK                                       */
/*==============================================================*/
create index ODBYWA_SIE_W_FK on POBYT (
NUMER_POKOJU ASC
);

/*==============================================================*/
/* Index: OPLACENIE_FK                                          */
/*==============================================================*/
create index OPLACENIE_FK on POBYT (
ID_KLIENTA ASC
);

/*==============================================================*/
/* Table: POKOJ                                                 */
/*==============================================================*/
create table POKOJ 
(
   NUMER_POKOJU         integer                        not null,
   LICZBA_MIEJSC        integer                        not null,
   STANDARD             char(20)                       null,
   CENA_ZA_NOC          numeric(8,2)                   not null,
   PIETRO               integer                        null,
   constraint PK_POKOJ primary key (NUMER_POKOJU)
);

comment on table POKOJ is 
'Lista Pokoi';

/*==============================================================*/
/* Index: POKOJ_PK                                              */
/*==============================================================*/
create unique index POKOJ_PK on POKOJ (
NUMER_POKOJU ASC
);

/*==============================================================*/
/* Table: PRACOWNIK                                             */
/*==============================================================*/
create table PRACOWNIK 
(
   ID_PRACOWNIKA        integer                        not null,
   NAZWISKO             char(50)                       not null,
   IMIE                 char(50)                       not null,
   STANOWISKO           char(50)                       not null,
   DATA_ZATRUDNIENIA    date                           not null,
   TELEFON              char(9)                        null,
   EMAIL                char(50)                       null,
   WYNAGRODZENIE        numeric(8,2)                   not null,
   constraint PK_PRACOWNIK primary key (ID_PRACOWNIKA)
);

comment on table PRACOWNIK is 
'Lista wszystkich pracownik w';

/*==============================================================*/
/* Index: PRACOWNIK_PK                                          */
/*==============================================================*/
create unique index PRACOWNIK_PK on PRACOWNIK (
ID_PRACOWNIKA ASC
);

/*==============================================================*/
/* Table: PRODUKTY_MINIBAROWE                                   */
/*==============================================================*/
create table PRODUKTY_MINIBAROWE 
(
   ID_PRODUKTU          integer                        not null,
   NAZWA_PRODUKTU       char(50)                       not null,
   ALKOHOL              smallint                       not null,
   "POJEMNOSC(ML)"      integer                        null,
   constraint PK_PRODUKTY_MINIBAROWE primary key (ID_PRODUKTU)
);

comment on table PRODUKTY_MINIBAROWE is 
'Lista produktow dostepnych w minibarku w kazdym pokoju';

/*==============================================================*/
/* Index: PRODUKTY_MINIBAROWE_PK                                */
/*==============================================================*/
create unique index PRODUKTY_MINIBAROWE_PK on PRODUKTY_MINIBAROWE (
ID_PRODUKTU ASC
);

/*==============================================================*/
/* Table: SPRZATANIE                                            */
/*==============================================================*/
create table SPRZATANIE 
(
   ID_SPRZATANIA        integer                        not null,
   ID_PRACOWNIKA        integer                        not null,
   NUMER_POKOJU         integer                        not null,
   DATA_SPRZATANIA      datetime                       not null,
   constraint PK_SPRZATANIE primary key clustered (ID_SPRZATANIA)
);

/*==============================================================*/
/* Index: SPRZATANIE_PK                                         */
/*==============================================================*/
create unique clustered index SPRZATANIE_PK on SPRZATANIE (
ID_SPRZATANIA ASC
);

/*==============================================================*/
/* Index: SPRZATANIE_FK                                         */
/*==============================================================*/
create index SPRZATANIE_FK on SPRZATANIE (
NUMER_POKOJU ASC
);

/*==============================================================*/
/* Index: SPRZATANIE2_FK                                        */
/*==============================================================*/
create index SPRZATANIE2_FK on SPRZATANIE (
ID_PRACOWNIKA ASC
);

/*==============================================================*/
/* Table: USLUGA                                                */
/*==============================================================*/
create table USLUGA 
(
   ID_USLUGI            integer                        not null,
   NAZWA_USLUGI         char(50)                       not null,
   CENA                 numeric(8,2)                   not null,
   JEDNOSTKA_ROZLICZENIOWA char(256)                      not null,
   constraint PK_USLUGA primary key (ID_USLUGI)
);

comment on table USLUGA is 
'Lista us ug jakie oferuje hotel';

/*==============================================================*/
/* Index: USLUGA_PK                                             */
/*==============================================================*/
create unique index USLUGA_PK on USLUGA (
ID_USLUGI ASC
);

/*==============================================================*/
/* Table: WYKORZYSTANE_USLUGI                                   */
/*==============================================================*/
create table WYKORZYSTANE_USLUGI 
(
   ID_WYKORZYSTANIA     integer                        not null,
   ID_POBYTU            integer                        not null,
   ID_USLUGI            integer                        not null,
   DATA_WYKORZYSTANIA   datetime                       not null,
   constraint PK_WYKORZYSTANE_USLUGI primary key clustered (ID_WYKORZYSTANIA)
);

/*==============================================================*/
/* Index: WYKORZYSTANE_USLUGI_PK                                */
/*==============================================================*/
create unique clustered index WYKORZYSTANE_USLUGI_PK on WYKORZYSTANE_USLUGI (
ID_WYKORZYSTANIA ASC
);

/*==============================================================*/
/* Index: WYKORZYSTANE_USLUGI_FK                                */
/*==============================================================*/
create index WYKORZYSTANE_USLUGI_FK on WYKORZYSTANE_USLUGI (
ID_USLUGI ASC
);

/*==============================================================*/
/* Index: WYKORZYSTANE_USLUGI2_FK                               */
/*==============================================================*/
create index WYKORZYSTANE_USLUGI2_FK on WYKORZYSTANE_USLUGI (
ID_POBYTU ASC
);

/*==============================================================*/
/* Table: ZUZYCIE                                               */
/*==============================================================*/
create table ZUZYCIE 
(
   ID_ZUZYCIA           integer                        not null,
   ID_POBYTU            integer                        not null,
   ID_PRODUKTU          integer                        not null,
   DATA_ZUZYCIA         datetime                       not null,
   constraint PK_ZUZYCIE primary key clustered (ID_ZUZYCIA)
);

/*==============================================================*/
/* Index: ZUZYCIE_PK                                            */
/*==============================================================*/
create unique clustered index ZUZYCIE_PK on ZUZYCIE (
ID_ZUZYCIA ASC
);

/*==============================================================*/
/* Index: ZUZYCIE_FK                                            */
/*==============================================================*/
create index ZUZYCIE_FK on ZUZYCIE (
ID_PRODUKTU ASC
);

/*==============================================================*/
/* Index: ZUZYCIE2_FK                                           */
/*==============================================================*/
create index ZUZYCIE2_FK on ZUZYCIE (
ID_POBYTU ASC
);

alter table GOSC
   add constraint FK_GOSC_MELDUNEK_POBYT foreign key (ID_POBYTU)
      references POBYT (ID_POBYTU)
      on update restrict
      on delete restrict;

alter table POBYT
   add constraint FK_POBYT_ODBYWA_SI_POKOJ foreign key (NUMER_POKOJU)
      references POKOJ (NUMER_POKOJU)
      on update restrict
      on delete restrict;

alter table POBYT
   add constraint FK_POBYT_OPLACENIE_KLIENT foreign key (ID_KLIENTA)
      references KLIENT (ID_KLIENTA)
      on update restrict
      on delete restrict;

alter table SPRZATANIE
   add constraint FK_SPRZATAN_W_POKOJ foreign key (NUMER_POKOJU)
      references POKOJ (NUMER_POKOJU)
      on update restrict
      on delete restrict;

alter table SPRZATANIE
   add constraint FK_SPRZATAN_WYKONUJE_PRACOWNI foreign key (ID_PRACOWNIKA)
      references PRACOWNIK (ID_PRACOWNIKA)
      on update restrict
      on delete restrict;

alter table WYKORZYSTANE_USLUGI
   add constraint FK_WYKORZYS_JAKA_USLUGA foreign key (ID_USLUGI)
      references USLUGA (ID_USLUGI)
      on update restrict
      on delete restrict;

alter table WYKORZYSTANE_USLUGI
   add constraint FK_WYKORZYS_PRZEZ_POBYT foreign key (ID_POBYTU)
      references POBYT (ID_POBYTU)
      on update restrict
      on delete restrict;

alter table ZUZYCIE
   add constraint "FK_ZUZYCIE_JAKI PROD_PRODUKTY" foreign key (ID_PRODUKTU)
      references PRODUKTY_MINIBAROWE (ID_PRODUKTU)
      on update restrict
      on delete restrict;

alter table ZUZYCIE
   add constraint FK_ZUZYCIE_KTORY_POBYT foreign key (ID_POBYTU)
      references POBYT (ID_POBYTU)
      on update restrict
      on delete restrict;
