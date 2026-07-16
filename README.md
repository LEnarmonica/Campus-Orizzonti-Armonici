# Campus Orizzonti Armonici 2026

App unificata per prenotazioni mensa e prenotazione aule.

Questa versione e' pronta per usare Supabase come archivio condiviso. Se `supabase-config.js` non viene compilato con i dati del progetto, l'app continua a funzionare in locale usando il browser, ma i dati non saranno condivisi tra dispositivi.

## File inclusi

- `index.html`: app completa.
- `supabase-config.js`: file da compilare con Project URL e anon public key.
- `supabase-config.example.js`: esempio di configurazione.
- `supabase-schema.sql`: schema da eseguire in Supabase.

## 1. Creare il database Supabase

1. Apri il tuo progetto Supabase.
2. Vai in `SQL Editor`.
3. Crea una nuova query.
4. Copia tutto il contenuto di `supabase-schema.sql`.
5. Incolla e premi `Run`.

Questo crea la tabella `app_state` e abilita il realtime.

## 2. Collegare l'app a Supabase

1. In Supabase apri `Project Settings`.
2. Vai in `Data API` e copia il `Project URL`.
3. Vai in `API Keys` e copia la chiave `anon public`.
4. Apri `supabase-config.js`.
5. Inserisci i valori:

```js
window.CAMPUS_SUPABASE = {
  url: "https://xxxxxxxxxxxx.supabase.co",
  anonKey: "eyJ..."
};
```

## 3. Pubblicare

Carica tutti i file di questa cartella nello stesso progetto/cartella pubblica:

```text
index.html
supabase-config.js
supabase-schema.sql
supabase-config.example.js
README.md
```

La parte Supabase gestisce i dati condivisi. La parte frontend puo essere pubblicata come sito statico, mantenendo `index.html` e `supabase-config.js` nella stessa cartella.

## 4. Password demo

- Admin: `admin2026`
- Operatore: `mensa2026`

Studenti e docenti entrano solo con nome e cognome.

## Note importanti

- Lo sfondo della landing puo essere caricato solo dall'admin.
- La foto viene compressa automaticamente prima del salvataggio.
- La sincronizzazione usa una tabella unica `app_state`: semplice, pratica e adatta a un campus/evento piccolo.
- Per un uso pubblico piu strutturato, il passo successivo sarebbe aggiungere Supabase Auth con ruoli veri.
