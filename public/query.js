
function createTable(myObj) {

    if (myObj.length == 0) {
        return "Nessun dato corrispondente alla ricerca"
    }

    att = Object.keys(myObj[0]);

    let text = `<table class='table table-striped'><thead>
                <tr>
                <th scope="col" style="width: 2rem">#</th>`
    for (let i = 0; i < att.length; i++) {
        text += `<th scope="col" style="fit-content">${att[i]}</th>`
    }
    text += `</tr>
            </thead><tbody class="table-group-divider">`

    for (let x in myObj) {
        row = myObj[x];
        text += `
        <tr>
        <th scope="row">${parseInt(x) + 1}</th>
        `;
        for (let i = 0; i < att.length; i++) {
            text += `<td>${row[att[i]]}</td>`
        };
        text += "</tr>"
    }
    text += "</tbody></table>"
    return text
}

let a;

function queryOp1() {
    let nome = document.querySelector("select").value;
    fetch("/centro?nome=" + nome).then(res => res.json()).then(json => {
        console.log(json);
        list = [];
        list.push(JSON.parse(json));
        document.getElementById("infos").innerHTML = createTable(JSON.parse(json));
    })
    fetch("/op1?nome='" + nome + "'").then(res => res.json()).then(json => {
        console.log(json)
        document.getElementById("result").innerHTML = createTable(JSON.parse(json));
    });
}

function queryOp2() {
    nome = document.querySelector("select").value.split(" ")[0];
    cognome = document.querySelector("select").value.split(" ")[1];

    fetch(`/op2?nome="${nome}"&cognome="${cognome}"`).then(res => res.json()).then(json => {
        console.log(json)
        document.getElementById("result").innerHTML = createTable(JSON.parse(json));
    })
}

function queryOp3() {
    nome = document.querySelector("select").value;
    rivista = document.querySelector("#rivista").value;

    fetch(`/op3?nome=${nome}&rivista=${rivista}`).then(res => res.json()).then(json => {
        console.log(json)
        document.getElementById("result").innerHTML = createTable(JSON.parse(json));
        fetchlist();
    })
}

function queryOp4() {
    codice = document.querySelector("select").value;

    fetch(`/op4?codice=${codice}`).then(res => res.json()).then(json => {
        console.log(json)
        document.getElementById("result").innerHTML = createTable(JSON.parse(json));
    })
}


function queryOp5() {
    nome = document.querySelector("select").value;

    fetch(`/op5?nome=${nome}`).then(res => res.json()).then(json => {
        console.log(json)
        document.getElementById("result").innerHTML = createTable(JSON.parse(json));
    })
}

function queryOp6() {
    fetch(`/op6`).then(res => res.json()).then(json => {
        console.log(json)
        document.getElementById("result").innerHTML = createTable(JSON.parse(json));
    })
}

function queryOp7() {
    nome = document.querySelector("select").value;

    fetch(`/op7?nome=${nome}`).then(res => res.json()).then(json => {
        console.log(json)
        document.getElementById("result").innerHTML = createTable(JSON.parse(json));
    })
}

function queryOp8() {
    nome = document.querySelector("select").value.split(" ")[0];
    cognome = document.querySelector("select").value.split(" ")[1];

    fetch(`/op8?nome="${nome}"&cognome="${cognome}"`).then(res => res.json()).then(json => {
        console.log(json)
        document.getElementById("result").innerHTML = createTable(JSON.parse(json));
    })
}

async function queryOp9(list, titolare) {
    console.log(list, titolare);
    if(!list.map(x => x.codice).includes( titolare.codice)) {
        console.log("non incluso");
        return {status: false};
    } 

    let res = await fetch("/team");
    let json = await res.json();
    let codiceteam = 1001 + JSON.parse(json).length;
    await fetch("/createteam?codice=" + codiceteam + "&titolare=" + titolare.codice);
    list.forEach(async e => {
        await fetch("/addtoteam?codice=" + e.codice + "&team=" + codiceteam);
    })
    return {status: true, team: codiceteam};
}

function queryOp10() {
    fetch(`/op10`).then(res => res.json()).then(json => {
        console.log(json)
        document.getElementById("result").innerHTML = createTable(JSON.parse(json));
    })
}

function queryVarianti() {
    fetch(`/varianti`).then(res => res.json()).then(json => {
        console.log(json)
        document.getElementById("result").innerHTML = createTable(JSON.parse(json));
    })
}

function queryGeni() {
    fetch(`/geni/all`).then(res => res.json()).then(json => {
        console.log(json)
        document.getElementById("result").innerHTML = createTable(JSON.parse(json));
    })
}

function queryOrganismi() {
    fetch(`/organismi/all`).then(res => res.json()).then(json => {
        console.log(json)
        document.getElementById("result").innerHTML = createTable(JSON.parse(json));
    })
}

function queryPubblicazioni() {
    fetch(`/pubblicazioni`).then(res => res.json()).then(json => {
        console.log(json)
        document.getElementById("result").innerHTML = createTable(JSON.parse(json));
    })
}