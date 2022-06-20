const express = require("express");
const { Sequelize, DataTypes, QueryTypes  } = require('sequelize');
const dotenv = require("dotenv");


const app = express();
app.use(express.static("public"));
app.use(express.json());
dotenv.config();

let port = 4000;
app.listen(port, () => {
    console.log("Listening on port 4000");
})

const sequelize = new Sequelize('genebase', process.env.DBUSER, process.env.PASSWORD, {
    host: 'localhost',
    dialect: 'mysql'
});

require('./queries')(app, sequelize, QueryTypes,DataTypes);


async function main() {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
}
main();


app.get("/centro", async (req, res) => {
    const result = await sequelize.query(`
    SELECT codice as Codice, nome as Nome, paese as Paese
    FROM centriricerca
    where nome="${req.query.nome}"
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/centri", async (req, res) => {
    const result = await sequelize.query(`
    SELECT nome
    FROM centriricerca
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/ricercatori", async (req, res) => {
    const result = await sequelize.query(`
    SELECT nome, cognome, codice
    FROM ricercatori
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/geni", async (req, res) => {
    const result = await sequelize.query(`
    SELECT DISTINCT codice
    FROM geni
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/organismi", async (req, res) => {
    const result = await sequelize.query(`
    SELECT nomecomune
    FROM organismi
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/condizioni", async (req, res) => {
    const result = await sequelize.query(`
    SELECT nome
    FROM condizioniassociate
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/team", async (req, res) => {
    const result = await sequelize.query(`
    SELECT codice
    FROM team
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/teamandric", async (req, res) => {
    const result = await sequelize.query(`
    SELECT t.codice as "Codice team", t.titolare as "Codice titolare", count(a.idricercatore) as "Numero partecipanti"
    FROM team t, appartenenze a
    WHERE t.codice = a.idteam and t.codice = ${req.query.team}
    GROUP BY t.codice, t.titolare
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/varianti", async (req, res) => {
    const result = await sequelize.query(`
    SELECT v.codicegene as Gene, v.idorganismo as Organismo, v.nome as Nome, v.lunghezza as Lunghezza, v.molecola as Molecola, count(c.intervallo) as "Numero CDS", v.sequenza as Sequenza
    FROM varianti v left outer join cds c on (c.variante = v.nome AND c.idgene = v.codicegene AND c.idorganismo = v.idorganismo)
    GROUP BY v.codicegene, v.idorganismo, v.nome, v.lunghezza, v.molecola, v.sequenza
    ORDER BY v.codicegene, v.idorganismo
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/geni/all", async (req, res) => {
    const result = await sequelize.query(`
    SELECT codice as Codice, idorganismo as Organismo, nome as Nome, tipo as Tipo, locus as Locus, descrizione as Descrizione
    FROM geni
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/organismi/all", async (req, res) => {
    const result = await sequelize.query(`
    SELECT nomescientifico as "Nome scientifico", nomecomune as "Nomecomune", tassonomia as "Tassonomia", rango as "Rango", classificatore as "Classificatore", annoclassificazione as "Anno classificazione"
    FROM organismi
    ORDER BY nomescientifico
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/pubblicazioni", async (req, res) => {
    const result = await sequelize.query(`
    SELECT idteam as Team, nome as Titolo, datainizio as "Data inizio", datapubblicazione as "Pubblicazione", rivista as "Rivista"
    FROM ricerchechiuse
    ORDER BY datapubblicazione DESC
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/ricercheaperte", async (req, res) => {
    const result = await sequelize.query(`
    SELECT nome
    from ricercheaperte
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})
