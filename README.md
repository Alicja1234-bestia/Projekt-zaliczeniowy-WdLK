# Projekt Zaliczeniowy – Wprowadzenie do Linuxa

## 🎯 Cel repozytorium

Repozytorium zostało stworzone w ramach projektu zaliczeniowego z przedmiotu
**Wprowadzenie do laboratorium komputerowego**.  
Jego celem jest zaprezentowanie umiejętności pracy z:

- systemem Linux
- skryptami Bash
- systemem kontroli wersji Git i GitHub
- składem tekstu w LaTeX

---

## 📁 Struktura repozytorium

### `bash/`
Katalog zawiera skrypty Bash realizujące zadania automatyzacyjne.

- `classification/`  
  Skrypt do automatycznego sortowania plików:
  - `inbox/` – katalog wejściowy
  - `classified/` – katalog docelowy 

- `duplicates/`  
  Skrypt do wyszukiwania i interaktywnego usuwania zduplikowanych plików:
  - `files/` – katalog z plikami do analizy

---

### `latex/`
Katalog zawiera dokumenty przygotowane w LaTeXu.

- `script/`  
  Połączony skrypt dla studentów:
  - `parts/` – pliki źródłowe `.tex`
  - `main.tex` – plik główny
  - `script_wdlk.pdf` – skompilowany dokument

- `instruction/`  
  Instrukcja techniczna w formacie PDF:
  - `screenshots/` – zrzuty ekranu
  - `main.tex` – plik źródłowy
  - `instruction.pdf` – gotowa instrukcja

---

## ▶️ Jak korzystać z repozytorium

### Praca ze skryptami Bash
Skrypty znajdują się w katalogu `bash/`. Przed uruchomieniem należy nadać im prawa do wykonania:
```bash
chmod +x nazwa_skryptu.sh
```

Następnie uruchomić skrypt
```bash
./nazwa_skryptu.sh
```

### Kompilacja dokumentów LaTeX

Aby skompilować dokument, przejdź do odpowiedniego katalogu i użyj:

```bash
pdflatex main.tex
```

