#!/usr/bin/env bash


# Tablica asocjacyjna: suma kontrolna -> lista plików
declare -A checksum_dict

# 1. ETAP: wyszukiwanie wszystkich plików i ich sum kontrolnych
for file in files/*; do
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
