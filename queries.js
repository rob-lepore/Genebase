module.exports = function (app, sequelize, QueryTypes,DataTypes) {


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
    `, { type: QueryTypes.SELECT });
        res.json(JSON.stringify(result, null, 2));
    })

    app.get("/op2", async (req, res) => {
        const result = await sequelize.query(`
    SELECT r.nome as Nome, r.cognome as Cognome, c.nome as "Centro di appartenenza" , numeropubblicazioni AS "Numero pubblicazioni" 
    FROM ricercatori r, centriricerca c
    WHERE r.nome = ${req.query.nome} AND r.cognome = ${req.query.cognome}
    AND c.codice = r.idcentro
    `, { type: QueryTypes.SELECT });
        res.json(JSON.stringify(result, null, 2));
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
        }, {
            where: {
                nome: req.query.nome,
            }
        })
        const result = await sequelize.query(`
    SELECT nome, datainizio, datapubblicazione, rivista, idteam
    FROM ricerchechiuse
    WHERE nome = "${req.query.nome}"
    `, { type: QueryTypes.SELECT });
        res.json(JSON.stringify(result, null, 2));
    })

    app.get("/op4", async (req, res) => {
        const result = await sequelize.query(`
    SELECT DISTINCT s.idorganismo as Organismo, s.nomericerca as Ricerca, r.idteam as Team
    FROM studicompletati s, ricerchechiuse r
    WHERE s.nomericerca = r.nome AND s.idgene = "${req.query.codice}"
    `, { type: QueryTypes.SELECT });
        res.json(JSON.stringify(result, null, 2));
    })

    app.get("/op5", async (req, res) => {
        const result = await sequelize.query(`
    SELECT distinct o.nomescientifico as "Nome scientifico", s.nomericerca as Ricerca, r.idteam as Team
    FROM studicompletati s, ricerchechiuse r, organismi o
    WHERE s.nomericerca = r.nome AND o.nomescientifico = s.idorganismo
	AND o.nomecomune = "${req.query.nome}"
    `, { type: QueryTypes.SELECT });
        res.json(JSON.stringify(result, null, 2));
    })

    app.get("/op6", async (req, res) => {
        const result = await sequelize.query(`
        SELECT t.codice as Codice, r.cognome as Titolare, count(rc.nome) as "Numero pubblicazioni"
        FROM team t LEFT OUTER JOIN ricerchechiuse rc on (t.codice = rc.idteam), ricercatori r
        WHERE r.codice = t.titolare
        GROUP BY t.codice, r.cognome
        ORDER BY t.codice
        `, { type: QueryTypes.SELECT });
        res.json(JSON.stringify(result, null, 2));
    })

    app.get("/op7", async (req, res) => {
        const result = await sequelize.query(`
    SELECT m.codicegene as Codice, m.idorganismo as Organismo, v.nome as Nome
    FROM manifestazioni m, varianti v
    WHERE v.codicegene = m.codicegene
    AND v.idorganismo = m.idorganismo
    AND m.condizione = "${req.query.nome}"
    ORDER BY m.codicegene, m.idorganismo
    `, { type: QueryTypes.SELECT });
        res.json(JSON.stringify(result, null, 2));
    })

    app.get("/op8", async (req, res) => {
        const result = await sequelize.query(`
    SELECT t.codice as Team, ra.nome as Ricerca, ra.datainizio as "Data apertura"
    FROM ricercatori r, appartenenze a, team t, ricercheaperte ra
    WHERE a.idricercatore = r.codice AND a.idteam = t.codice AND ra.idteam = t.codice
    AND r.nome = ${req.query.nome} AND r.cognome = ${req.query.cognome}
    ORDER BY ra.datainizio
    `, { type: QueryTypes.SELECT });
        res.json(JSON.stringify(result, null, 2));
    })

    app.get("/createteam", async (req, res) => {
        const result = await sequelize.query(`
        INSERT INTO team values (${req.query.codice}, ${req.query.titolare})
        `, { type: QueryTypes.INSERT });
        res.json(JSON.stringify(result, null, 2))
    })

    app.get("/addtoteam", async (req, res) => {
        const result = await sequelize.query(`
        INSERT INTO appartenenze values (${req.query.codice},${req.query.team})
        `, { type: QueryTypes.INSERT });
        res.json(JSON.stringify(result, null, 2))

    })

    app.get("/op10", async (req, res) => {
        const result = await sequelize.query(`
        select r.nome as Nome, r.cognome as Cognome, r.codice as ID, count(distinct s.idgene, s.idorganismo) as "Geni studiati"
        from ricercatori r, appartenenze a, team t, ricerchechiuse rc, studicompletati s
        where r.codice = a.idricercatore and t.codice = a.idteam and rc.idteam = t.codice 
        and s.nomericerca = rc.nome
        group by r.nome, r.cognome, r.codice
        having count(distinct s.idgene, s.idorganismo) = (
            select count(distinct s.idgene, s.idorganismo) as "Geni studiati"
            from ricercatori r, appartenenze a, team t, ricerchechiuse rc, studicompletati s
            where r.codice = a.idricercatore and t.codice = a.idteam and rc.idteam = t.codice 
            and s.nomericerca = rc.nome
            group by r.nome, r.cognome, r.codice
            limit 1
        )
        `, { type: QueryTypes.SELECT });
        res.json(JSON.stringify(result, null, 2));
    })
}