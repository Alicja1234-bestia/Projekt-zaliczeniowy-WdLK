#!/usr/bin/env bash

# Sprawdzenie liczby argumentów
if [[ $# -ne 1 ]]; then
    echo "Zła ilość argumentów, musisz podać jeden katalog"
    exit 1
fi

path="$1"

# Sprawdzenie czy argument jest katalogiem
if [[ ! -d "$path" ]]; then
    echo "W argumencie musisz podać nazwę katalogu"
    exit 1
fi

# Tablica asocjacyjna: suma kontrolna -> lista plików
declare -A checksum_dict

# 1. ETAP: wyszukiwanie wszystkich plików i ich sum kontrolnych
for file in "$path"/*; do
    [[ -f "$file" ]] || continue

    checksum=$(sha256sum "$file" | cut -d ' ' -f1)

    # Dopisujemy plik do listy (każdy w nowej linii)
    checksum_dict[$checksum]+="$file"$'\n'
done

# 2. ETAP: wypisywanie i obsługa duplikatów
for checksum in "${!checksum_dict[@]}"; do
    files="${checksum_dict[$checksum]}"

    # Liczymy ile plików ma tę samą sumę
    file_count=$(echo "$files" | grep -c .)

    # Jeśli więcej niż 1 → są duplikaty
    if [[ $file_count -gt 1 ]]; then
        echo "----------------------------------------"
        echo "Znaleziono duplikaty (suma: $checksum):"
        echo "$files"

        first=true
        while IFS= read -r file; do
            # Pierwszy plik traktujemy jako oryginał
            if $first; then
                first=false
                continue
            fi

            # Pytanie o usunięcie duplikatu
            read -p "Czy usunąć plik $file ? [t/N] " odpowiedz
            if [[ "$odpowiedz" == "t" || "$odpowiedz" == "T" ]]; then
                rm "$file"
                echo "Usunięto $file"
            else
                echo "Pozostawiono $file"
            fi
        done <<< "$files"
    fi
done
