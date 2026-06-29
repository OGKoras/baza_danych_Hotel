# Projekt Bazy Danych – Hotel

Kompleksowy projekt relacyjnej bazy danych zaimplementowany w dwóch systemach: Sybase Central oraz MySQL. System składa się z 10 powiązanych tabel, 3 widoków oraz zaawansowanej logiki biznesowej: 3 funkcji i 3 procedur (w tym z wykorzystaniem kursora i transakcji lokalnej). Projekt zawiera również konfigurację uprawnień dla 3 użytkowników oraz pełną dokumentację techniczną.

## 📁 Struktura projektu

Repozytorium zostało podzielone na trzy główne foldery:

* **`skrypty_mysql/`** – zawiera kompletne skrypty SQL (DDL oraz DML) dostosowane do systemu zarządzania bazą danych MySQL.
* **`skrypty_sybase/`** – zawiera odpowiedniki skryptów zaimplementowane i przetestowane w środowisku Sybase Central (T-SQL).
* **`dokumentacja/`** – pełna dokumentacja projektowa i techniczna systemu.

---

## 📄 Zawartość dokumentacji

W folderze z dokumentacją znajdują się szczegółowe materiały opisujące architekturę i działanie bazy danych, w tym:

1.  **Model konceptualny** – teoretyczny opis powiązań i założeń biznesowych systemu rezerwacji hotelowej.
2.  **Diagram fizyczny (ERD)** – graficzny schemat przedstawiający strukturę 10 tabel, klucze główne (PK), klucze obce (FK) oraz typy danych.
3.  **Opisy obiektów bazy danych**:
    * **3 Widoki (Views)** – zapytania optymalizujące i ułatwiające dostęp do najczęściej przetwarzanych informacji.
    * **3 Funkcje (Functions)** – czysta logika obliczeniowa zaszyta po stronie serwera bazodanowego.
    * **3 Procedury (Stored Procedures)** – zaawansowane operacje na danych, w tym dedykowana procedura realizująca **lokalną transakcję** (zapewniająca spójność danych) oraz procedura wykorzystująca **kursor** do sekwencyjnego przetwarzania wierszy.
4.  **Zarządzanie bezpieczeństwem** – opis ról i uprawnień zdefiniowanych dla 3 różnych użytkowników systemu.

---

## 🛠️ Technologia

* **DBMS:** MySQL, Sybase Central (SQL Anywhere)
* **Język zapytań:** SQL / T-SQL
