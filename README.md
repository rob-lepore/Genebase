# GENEBASE

### Progetto d'esame per il corso Basi di dati
#### Roberto Lepore

  

NB. Per l'esecuzione locale è necessaria un'installazione di [Node.js](https://nodejs.org/it/).

  

## Procedimento per l'installazione locale:

- Importare il database in un server locale MySQL attraverso il file `genebase_sql.sql`

- Estrarre la cartella compressa

- Creare nella root un file e chiamarlo `.env`

- Copiare nel file `.env` il testo presente nel file `esempioenv.txt`, sostituendo `<username>` e `<password>` con le proprie credenziali del server MySQL locale.

- Aprire una shell nella cartella del progetto e eseguire i seguenti comandi:
```
    $ npm i
    $ npm run start
```
- Aprire un web browser e recarsi all'indirizzo http://localhost:4000