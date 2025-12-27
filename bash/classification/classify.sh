#!/usr/bin/env bash

# Katalog wejściowy – 1. argument, domyślnie "inbox"
path_to_inbox="${1:-inbox}"

# Katalog wyjściowy – 2. argument, domyślnie "classified"
path_to_output="${2:-classified}"

# Sprawdzenie czy katalog inbox istnieje
if [[ ! -d "$path_to_inbox" ]]; then
    echo "Błąd: katalog wejściowy '$path_to_inbox' nie istnieje."
    exit 1
fi

# Utworzenie katalogu wyjściowego
mkdir -p "$path_to_output"

for file in "$path_to_inbox"/*; do
    # Jeśli brak plików – pomiń
    [ -e "$file" ] || continue

    # Odczyt kategorii z pliku
    category=$(grep -i "^CATEGORY:" "$file" | cut -d':' -f2 | tr -d '[:space:]')

    # Jeśli brak kategorii – użyj "unknown"
    if [[ -z "$category" ]]; then
        category="unknown"
    fi

    # Utworzenie katalogu kategorii
    mkdir -p "$path_to_output/$category"

    # Przeniesienie pliku
    mv "$file" "$path_to_output/$category/"

    echo "Plik $(basename "$file") przeniesiono do $path_to_output/$category/"
done
