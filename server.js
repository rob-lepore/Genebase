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

const Ricerchechiuse = sequelize.define('ricerchechiuse', {
    nome: {
        type: DataTypes.STRING,
        allowNull: false,
        primaryKey: true,
    },
    datainizio: {
        type: DataTypes.DATE,
        allowNull: false,
    },
    datapubblicazione: {
        type: DataTypes.DATE,
        allowNull: false,
    },
    rivista: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    idteam: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
}, {
    tableName: "ricerchechiuse",
    timestamps: false,
});


const Ricercheaperte = sequelize.define('ricercheaperte', {
    nome: {
        type: DataTypes.STRING,
        allowNull: false,
        primaryKey: true,
    },
    datainizio: {
        type: DataTypes.DATE,
        allowNull: false,
    },
    idteam: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
}, {
    tableName: "ricercheaperte",
    timestamps: false,
});



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
    SELECT nome, cognome
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

app.get("/op1", async (req, res) => {
    const result = await sequelize.query(`
    SELECT rc.rivista, COUNT(distinct rc.nome) as "numero pubblicazioni"
    FROM centriricerca c, ricercatori r, appartenenze a, team t, 
      ricerchechiuse rc
    WHERE c.nome = ${req.query.nome}
     AND r.idcentro = c.codice
     AND a.idricercatore = r.codice
     AND a.idteam = t.codice 
     AND rc.idteam = t.codice
    GROUP BY rc.rivista
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/op2", async (req, res) => {
    const result = await sequelize.query(`
    SELECT r.nome as Nome, r.cognome as Cognome, c.nome as "Centro di appartenenza" , numeropubblicazioni AS "Numero pubblicazioni" 
    FROM ricercatori r, centriricerca c
    WHERE r.nome = ${req.query.nome} AND r.cognome = ${req.query.cognome}
    AND c.codice = r.idcentro
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/op3", async (req, res) => {
    console.log(req.query)
    await Ricercheaperte.destroy({
        where: {
            nome: req.query.nome,
        }
    })
    await Ricerchechiuse.update({
        rivista: req.query.rivista
    },{
        where: {
            nome: req.query.nome,
        }
    })
    const result = await sequelize.query(`
    SELECT nome, datainizio, datapubblicazione, rivista, idteam
    FROM ricerchechiuse
    WHERE nome = "${req.query.nome}"
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/op4", async (req, res) => {
    const result = await sequelize.query(`
    SELECT DISTINCT s.idorganismo as Organismo, s.nomericerca as Ricerca, r.idteam as Team
    FROM varianti v, studicompletati s, ricerchechiuse r
    WHERE s.nomericerca = r.nome AND s.nomevariante = v.nome AND s.idgene = v.codicegene AND s.idorganismo = v.idorganismo 
	AND v.codicegene = "${req.query.codice}"
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/op5", async (req, res) => {
    const result = await sequelize.query(`
    SELECT distinct o.nomescientifico as "Nome scientifico", s.nomericerca as Ricerca, r.idteam as Team
    FROM studicompletati s, ricerchechiuse r, organismi o
    WHERE s.nomericerca = r.nome AND o.nomescientifico = s.idorganismo
	AND o.nomecomune = "${req.query.nome}"
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/op6", async (req, res) => {
    const result = await sequelize.query(`
    SELECT t.codice as Codice, r.cognome as Titolare, count(*) as "Numero pubblicazioni"
    FROM team t, ricerchechiuse rc, ricercatori r
    WHERE t.codice = rc.idteam AND r.codice = t.titolare
    GROUP BY t.codice, r.nome, r.cognome
    ORDER BY t.codice
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/op7", async (req, res) => {
    const result = await sequelize.query(`
    SELECT m.codicegene as Codice, g.nome as Nome, m.idorganismo as Organismo
    FROM condizioniassociate c, manifestazioni m, geni g
    WHERE m.condizione = c.nome 
    AND m.codicegene = g.codice
    AND m.idorganismo = g.idorganismo
    AND m.condizione = "${req.query.nome}"
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})

app.get("/op8", async (req, res) => {
    const result = await sequelize.query(`
    SELECT t.codice as Team, ra.nome as Ricerca, ra.datainizio as "Data apertura"
    FROM ricercatori r, appartenenze a, team t, ricercheaperte ra
    WHERE a.idricercatore = r.codice AND a.idteam = t.codice AND ra.idteam = t.codice
    AND r.nome = ${req.query.nome} AND r.cognome = ${req.query.cognome}
    ORDER BY ra.datainizio
    `,{ type: QueryTypes.SELECT });
    res.json( JSON.stringify(result, null, 2));
})