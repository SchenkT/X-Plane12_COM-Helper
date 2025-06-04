import requests

# ⇨ DEIN SIMBRIEF BENUTZERNAME HIER EINTRAGEN
SIMBRIEF_USERNAME = "174902"  # <- z. B. "flythom" oder dein echter SimBrief-Nutzername

# ⇨ Ziel-Dateiname im aktuellen Verzeichnis
output_filename = "simbrief_flightplan.json"

# ⇨ JSON-API-URL
url = f"https://www.simbrief.com/api/json.fetcher.php?userid={SIMBRIEF_USERNAME}"

# ⇨ Daten holen
response = requests.get(url)

if response.status_code == 200:
    with open(output_filename, "w", encoding="utf-8") as f:
        f.write(response.text)
    print(f"✅ Flugplan gespeichert als '{output_filename}'.")
else:
    print(f"❌ Fehler beim Abrufen des Flugplans: HTTP {response.status_code}")
