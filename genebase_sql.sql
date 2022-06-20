DROP DATABASE IF EXISTS genebase;

CREATE DATABASE IF NOT EXISTS genebase;

USE genebase;

CREATE TABLE `ricercatori` (
  `codice` int NOT NULL,
  `nome` varchar(45) NOT NULL,
  `cognome` varchar(45) NOT NULL,
  `idcentro` varchar(45) NOT NULL,
  `numeropubblicazioni` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `appartenenze` (
  `idricercatore` int NOT NULL,
  `idteam` int NOT NULL,
  PRIMARY KEY (`idricercatore`,`idteam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cds` (
  `intervallo` varchar(45) NOT NULL,
  `variante` varchar(45) NOT NULL,
  `idgene` varchar(45) NOT NULL,
  `idorganismo` varchar(45) NOT NULL,
  PRIMARY KEY (`intervallo`,`variante`,`idgene`,`idorganismo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `centriricerca` (
  `codice` int NOT NULL,
  `nome` varchar(45) NOT NULL,
  `paese` varchar(45) NOT NULL,
  PRIMARY KEY (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `condizioniassociate` (
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `geni` (
  `codice` varchar(10) NOT NULL,
  `idorganismo` varchar(45) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `tipo` varchar(45) NOT NULL,
  `locus` varchar(45) NOT NULL,
  `descrizione` varchar(1000) NOT NULL,
  PRIMARY KEY (`codice`,`idorganismo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `manifestazioni` (
  `condizione` varchar(45) NOT NULL,
  `codicegene` varchar(45) NOT NULL,
  `idorganismo` varchar(45) NOT NULL,
  PRIMARY KEY (`condizione`,`codicegene`,`idorganismo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `organismi` (
  `nomescientifico` varchar(50) NOT NULL,
  `nomecomune` varchar(45) NOT NULL,
  `tassonomia` varchar(500) NOT NULL,
  `rango` varchar(45) NOT NULL,
  `classificatore` varchar(45) NOT NULL,
  `annoclassificazione` smallint NOT NULL,
  PRIMARY KEY (`nomescientifico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ricercheaperte` (
  `nome` varchar(200) NOT NULL,
  `datainizio` date NOT NULL,
  `idteam` varchar(45) NOT NULL,
  PRIMARY KEY (`nome`),
  UNIQUE KEY `idteam_UNIQUE` (`idteam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ricerchechiuse` (
  `nome` varchar(200) NOT NULL,
  `datainizio` date NOT NULL,
  `datapubblicazione` date NOT NULL,
  `rivista` varchar(45) NOT NULL,
  `idteam` int NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `studi` (
  `nomericerca` varchar(500) NOT NULL,
  `nomevariante` varchar(45) NOT NULL,
  `idgene` varchar(45) NOT NULL,
  `idorganismo` varchar(45) NOT NULL,
  PRIMARY KEY (`nomericerca`,`nomevariante`,`idgene`,`idorganismo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `studicompletati` (
  `nomericerca` varchar(500) NOT NULL,
  `nomevariante` varchar(45) NOT NULL,
  `idgene` varchar(45) NOT NULL,
  `idorganismo` varchar(45) NOT NULL,
  PRIMARY KEY (`nomericerca`,`nomevariante`,`idgene`,`idorganismo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `team` (
  `codice` int NOT NULL,
  `titolare` int NOT NULL,
  PRIMARY KEY (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `varianti` (
  `nome` varchar(45) NOT NULL,
  `codicegene` varchar(45) NOT NULL,
  `idorganismo` varchar(45) NOT NULL,
  `lunghezza` int NOT NULL,
  `molecola` varchar(45) NOT NULL,
  `sequenza` varchar(1300) NOT NULL,
  PRIMARY KEY (`nome`,`codicegene`,`idorganismo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

delete from centriricerca where codice>0;
insert into centriricerca values ("1","Aarhus University", "Danimarca");
insert into centriricerca values ("2","Aix-Marseille Université", "Francia");
insert into centriricerca values ("3","Bionext", "Francia");
insert into centriricerca values ("4","Botanic Institute of Barcelona", "Spagna");
insert into centriricerca values ("5","CBS-KNAW Fungal Biodiversity Centre", "Paesi Bassi");
insert into centriricerca values ("6","DKFZ Heidelberg", "Germania");

delete from ricercatori where codice>0;
insert into ricercatori values ("1", "Max", "Boyd", "1", 5);
insert into ricercatori values ("2", "Saara", "Greer", "1", 4);
insert into ricercatori values ("3", "Katy", "Hicks", "1", 4);
insert into ricercatori values ("4", "Anand", "Cruz", "1", 6);
insert into ricercatori values ("5", "Alyx", "Shields", "2", 5);
insert into ricercatori values ("6", "Jeremy", "Weir", "2", 2);
insert into ricercatori values ("7", "Theo", "Marquez", "2", 2);
insert into ricercatori values ("8", "Sharson", "Mcgregor", "2", 2);
insert into ricercatori values ("9", "Raheel", "Cowan", "3", 6);
insert into ricercatori values ("10", "Natalie", "Sinclair", "3", 2);
insert into ricercatori values ("11", "Jamie", "Richardson", "3", 2);
insert into ricercatori values ("12", "Leslie", "Mack", "4", 2);
insert into ricercatori values ("13", "Humera", "Mills", "4", 2);
insert into ricercatori values ("14", "Umar", "Mejia", "4", 2);
insert into ricercatori values ("15", "Ioan", "Redmond", "5", 2);
insert into ricercatori values ("16", "Carolyn", "Montoya", "5", 5);
insert into ricercatori values ("17", "Talia", "Roberson", "6", 4);
insert into ricercatori values ("18", "Ishmael", "Hirst", "6",2);
insert into ricercatori values ("19", "Dionne", "Britton", "6",4);
insert into ricercatori values ("20", "Leona", "Leech", "6",4);

delete from team where codice > 0;
insert into team values ("1001", 1);
insert into team values ("1002", 2);
insert into team values ("1003", 11);
insert into team values ("1004", 6);
insert into team values ("1005", 4);
insert into team values ("1006", 4);
insert into team values ("1007", 2);
insert into team values ("1008", 18);
insert into team values ("1009", 12);
insert into team values ("1010", 10);

delete from appartenenze where idricercatore > 0;
insert into appartenenze values("1", "1001");
insert into appartenenze values("5", "1001");
insert into appartenenze values("16", "1001");
insert into appartenenze values("1", "1002");
insert into appartenenze values("2", "1002");
insert into appartenenze values("9", "1002");
insert into appartenenze values("11", "1003");
insert into appartenenze values("20", "1003");
insert into appartenenze values("16", "1003");
insert into appartenenze values("13", "1004");
insert into appartenenze values("6", "1004");
insert into appartenenze values("19", "1004");
insert into appartenenze values("4", "1005");
insert into appartenenze values("9", "1005");
insert into appartenenze values("17", "1005");
insert into appartenenze values("15", "1006");
insert into appartenenze values("14", "1006");
insert into appartenenze values("4", "1006");
insert into appartenenze values("2", "1007");
insert into appartenenze values("17", "1007");
insert into appartenenze values("20", "1007");
insert into appartenenze values("3", "1008");
insert into appartenenze values("18", "1008");
insert into appartenenze values("4", "1008");
insert into appartenenze values("3", "1009");
insert into appartenenze values("5", "1009");
insert into appartenenze values("12", "1009");
insert into appartenenze values("8", "1009");
insert into appartenenze values("19", "1010");
insert into appartenenze values("9", "1010");
insert into appartenenze values("7", "1010");
insert into appartenenze values("10", "1010");



delete from ricerchechiuse where nome != "a";
insert into ricerchechiuse values("The complete sequence of dystrophin predicts a rod-shaped cytoskeletal protein", "1986-01-01", "1988-01-01", "Nature", 1001);
insert into ricerchechiuse values("Antioxidant Effect of Thioredoxin and Vitamin D3 in Peritoneal Dialysis Patients", "1977-04-08", "1979-04-08", "Advanced Materials", 1001);
insert into ricerchechiuse values("Validation and classification of RNA binding proteins identified by mRNA interactome capture", "1977-10-10", "1979-10-08", "Chemical Reviews", 1002);
insert into ricerchechiuse values("Compensatory Protection of Thioredoxin-Deficient Cells from Etoposide-Induced Cell Death", "1979-07-09", "1983-04-09", "Nucleic Acids Research", 1002);
insert into ricerchechiuse values("Imbalance in thioredoxin system activates NLRP3 inflammasome pathway in epicardial adipose tissue of patients with coronary artery disease", "1980-12-31", "1981-02-02", "Nucleic Acids Research", 1003);
insert into ricerchechiuse values("Secretion of thioredoxin by normal and neoplastic cells through a leaderless secretory pathway", "1982-07-29", "1985-04-21", "Journal of Clinical Oncology", 1003);
insert into ricerchechiuse values("Gene Model Annotations for Drosophila melanogaster: Impact of High-Throughput Data", "1984-06-08", "1987-12-08", "Science", 1004);
insert into ricerchechiuse values("Gene Model Annotations for Drosophila melanogaster: The Rule-Benders", "1990-08-03", "1979-11-08", "Nature", 1004);
insert into ricerchechiuse values("The Release 6 reference sequence of the Drosophila melanogaster genome", "1992-07-30", "1993-09-08", "Nature", 1005);
insert into ricerchechiuse values("Gene conversions in the growth hormone gene family of primates: stronger homogenizing effects in the Hominidae lineage", "1993-06-24", "1998-01-21", "Journal of Clinical Oncology", 1005);
insert into ricerchechiuse values("Growth hormone-related genes from baboon (Papio hamadryas): Characterization, placental expression and evolutionary aspects", "1995-11-21", "1999-05-31", "Nucleic Acids Research", 1006);
insert into ricerchechiuse values("The primary structure of monkey pituitary growth hormone", "1995-11-23", "1997-03-22", "Journal of Clinical Oncology", 1006);
insert into ricerchechiuse values("Complete cloning of the Duchenne muscular dystrophy (DMD) cDNA", "1986-01-01", "1987-01-01","Cell", 1007);
insert into ricerchechiuse values("High Prevalence of Nonalcoholic Fatty Liver Disease Among Adolescents and Young Adults With Hypopituitarism due to Growth Hormone Deficiency", "1998-10-19", "1999-01-09", "Science", 1007);
insert into ricerchechiuse values("Mutations in GH1 gene and isolated growth hormone deficiency", "1999-06-15", "2000-02-22", "Nucleic Acids Research", 1008);
insert into ricerchechiuse values("Adaptive genic evolution in the Drosophila genomes", "2000-05-05", "2000-09-11", "Cell", 1008);
insert into ricerchechiuse values("Mitochondrial DNA sequence evolution and phylogeny in the genus Mus", "2000-09-08", "2001-09-19", "Journal of Clinical Oncology", 1009);
insert into ricerchechiuse values("Identification of a new copper metabolism gene by positional cloning in a purebred dog population", "2001-03-23", "2003-01-25", "Science", 1009);
insert into ricerchechiuse values("Detection and characterization of interleukin-6 gene variants in Canis familiaris: Association studies with periodontal disease", "2004-05-24", "2006-11-08", "Cell", 1010);
insert into ricerchechiuse values("Conservation of the Duchenne muscular dystrophy gene in mice and humans", "1988-01-01", "1990-01-01", "Science",1010);

DROP TRIGGER IF EXISTS chiudi_ricerca;
delete from ricercheaperte where nome != "";

DELIMITER $$
CREATE TRIGGER chiudi_ricerca 
BEFORE DELETE on ricercheaperte
FOR EACH ROW
BEGIN
	INSERT INTO ricerchechiuse(nome, datainizio, datapubblicazione, rivista, idteam) 
    values(OLD.nome,OLD.datainizio,now(),"Nature",OLD.idteam);
    delete from studi where nomericerca = OLD.nome;
    UPDATE ricercatori set numeropubblicazioni = numeropubblicazioni + 1 where codice in (
		select idricercatore
		from appartenenze
		where idteam = OLD.idteam
	) ;
END$$

DELIMITER ;
insert into ricercheaperte values("A public genome-scale lentiviral expression library of human ORFs", "2011-11-11", 1001);
insert into ricercheaperte values("Novel alleles of the TGFB1 regulatory region and exon 1", "2014-12-08", 1002);
insert into ricercheaperte values("14-3-3zeta Constrains insulin secretion by regulating mitochondrial function in pancreatic beta cells", "2018-09-13", 1003);
insert into ricercheaperte values("Dystrophin cytochemistry in mdx mouse muscles injected with labeled normal myoblasts", "2018-11-09", 1004);
insert into ricercheaperte values("Cancer-associated alternative usage of multiple promoters of human GalCer sulfotransferase gene", "2020-03-05", 1005);
insert into ricercheaperte values("The prognostic value of galactosylceramide-sulfotransferase (Gal3ST1) in human renal cell carcinoma", "2020-03-12", 1006);
insert into ricercheaperte values("Inferring nonneutral evolution from human-chimp-mouse orthologous gene trios", "2020-04-10", 1007);
insert into ricercheaperte values("Molecular Phylogeny and Dating of Early Primate Divergences", "2021-01-29", 1008);
insert into ricercheaperte values("G protein-coupled receptors and adipogenesis: a focus on adenosine receptors", "2021-06-22", 1009);
insert into ricercheaperte values("A3 receptor ligands: past, present and future trends", "2021-10-13", 1010);

delete from organismi where nomescientifico != "";
insert into organismi values("Homo sapiens", "human", "Eukaryota; Opisthokonta; Metazoa; Eumetazoa; Bilateria; Deuterostomia; Chordata; Craniata; Vertebrata; Gnathostomata; Teleostomi; Euteleostomi; Sarcopterygii; Dipnotetrapodomorpha; Tetrapoda; Amniota; Mammalia; Theria; Eutheria; Boreoeutheria; Euarchontoglires; Primates; Haplorrhini; Simiiformes; Catarrhini; Hominoidea; Hominidae; Homininae; Homo", "species", "Linnaeus", 1758);
insert into organismi values("Drosophila melanogaster", "fruit fly", "Eukaryota; Opisthokonta; Metazoa; Eumetazoa; Bilateria; Protostomia; Ecdysozoa; Panarthropoda; Arthropoda; Mandibulata; Pancrustacea; Hexapoda; Insecta; Dicondylia; Pterygota; Neoptera; Endopterygota; Diptera; Brachycera; Muscomorpha; Eremoneura; Cyclorrhapha; Schizophora; Acalyptratae; Ephydroidea; Drosophilidae; Drosophilinae; Drosophilini; Drosophila; Sophophora", "species", "Meigen", 1830);
insert into organismi values("Mus musculus", "house mouse", "Eukaryota; Opisthokonta; Metazoa; Eumetazoa; Bilateria; Deuterostomia; Chordata; Craniata; Vertebrata; Gnathostomata; Teleostomi; Euteleostomi; Sarcopterygii; Dipnotetrapodomorpha; Tetrapoda; Amniota; Mammalia; Theria; Eutheria; Boreoeutheria; Euarchontoglires; Glires; Rodentia; Myomorpha; Muroidea; Muridae; Murinae; Mus", "species", "Linnaeus", 1758);
insert into organismi values("Felis catus", "domestic cat", "Eukaryota; Opisthokonta; Metazoa; Eumetazoa; Bilateria; Deuterostomia; Chordata; Craniata; Vertebrata; Gnathostomata; Teleostomi; Euteleostomi; Sarcopterygii; Dipnotetrapodomorpha; Tetrapoda; Amniota; Mammalia; Theria; Eutheria; Boreoeutheria; Laurasiatheria; Carnivora; Feliformia; Felidae; Felinae; Felis", "species", "Linnaeus", 1758);
insert into organismi values("Pan troglodytes", "chimpanzee", "Eukaryota; Opisthokonta; Metazoa; Eumetazoa; Bilateria; Deuterostomia; Chordata; Craniata; Vertebrata; Gnathostomata; Teleostomi; Euteleostomi; Sarcopterygii; Dipnotetrapodomorpha; Tetrapoda; Amniota; Mammalia; Theria; Eutheria; Boreoeutheria; Euarchontoglires; Primates; Haplorrhini; Simiiformes; Catarrhini; Hominoidea; Hominidae; Homininae; Pan", "species", "Linnaeus", 1758);
insert into organismi values("Canis", "dog", "Eukaryota; Opisthokonta; Metazoa; Eumetazoa; Bilateria; Deuterostomia; Chordata; Craniata; Vertebrata; Gnathostomata; Teleostomi; Euteleostomi; Sarcopterygii; Dipnotetrapodomorpha; Tetrapoda; Amniota; Mammalia; Theria; Eutheria; Boreoeutheria; Laurasiatheria; Carnivora; Caniformia; Canidae", "genus", "Linnaeus", 1758);


delete from geni where codice != "";
insert into geni values("DMD", "Homo sapiens", "dystrophin", "protein coding", "Xp21.2-p21.1", "This gene spans a genomic range of greater than 2 Mb and encodes a large protein containing an N-terminal actin-binding domain and multiple spectrin repeats. The encoded protein forms a component of the dystrophin-glycoprotein complex (DGC), which bridges the inner cytoskeleton and the extracellular matrix. Deletions, duplications, and point mutations at this gene locus may cause Duchenne muscular dystrophy (DMD), Becker muscular dystrophy (BMD), or cardiomyopathy. Alternative promoter usage and alternative splicing result in numerous distinct transcript variants and protein isoforms for this gene.");
insert into geni values("DMD","Mus musculus","dystrophin","protein coding","XC1","This gene encodes a large, rod-like cytoskeletal protein which is found at the inner surface of muscle fibers in skeletal and cardiac muscles. The encoded protein, dystrophin, is part of the dystrophin-glycoprotein complex, which bridges the inner cytoskeleton (F-actin) and the extra-cellular matrix. This protein is required for proper development and organization of myofibers as contractile units in striated muscles. Mutations in the human gene cause Duchenne and Becker Muscular Dystrophies and a form of heart disease called DMD-associated dilated cardiomyopathy. Several alternatively spliced transcript variants of this gene have been described, but the full-length nature of some of these variants has not been determined.");
insert into geni values("TXN","Homo sapiens","thioredoxin","protein coding","9q31.3","The protein encoded by this gene acts as a homodimer and is involved in many redox reactions. The encoded protein is active in the reversible S-nitrosylation of cysteines in certain proteins, which is part of the response to intracellular nitric oxide. This protein is found in the cytoplasm. Two transcript variants encoding different isoforms have been found for this gene.");
insert into geni values("INDY","Drosophila melanogaster","I'm not dead yet","protein coding","75E1-75E2","Enables citrate transmembrane transporter activity; pyruvate transmembrane transporter activity; and succinate transmembrane transporter activity. Involved in carboxylic acid transport; determination of adult lifespan; and regulation of sequestering of triglyceride");
insert into geni values("GH1","Pan troglodytes","growth hormone 1","protein coding","17","Growth hormone 1.");
insert into geni values("IL6","Canis","interleukin 6","protein coding","14","Interleukin 6.");
insert into geni values("TGFB1","Homo sapiens","transforming growth factor beta 1","protein coding","19q13.2","This gene encodes a secreted ligand of the TGF-beta (transforming growth factor-beta) superfamily of proteins. Ligands of this family bind various TGF-beta receptors leading to recruitment and activation of SMAD family transcription factors that regulate gene expression. The encoded preproprotein is proteolytically processed to generate a latency-associated peptide (LAP) and a mature peptide, and is found in either a latent form composed of a mature peptide homodimer, a LAP homodimer, and a latent TGF-beta binding protein, or in an active form consisting solely of the mature peptide homodimer.");
insert into geni values("RLN", "Felis catus", "relaxin", "protein coding", "D4", "Relaxin.");


delete from varianti where nome != "";
insert into varianti values("Complete cds", "DMD", "Homo sapiens", 13957, "linear mRNA", "1 gggattccct cactttcccc ctacaggact cagatctggg aggcaattac cttcggagaa
       61 aaacgaatag gaaaaactga agtgttactt tttttaaagc tgctgaagtt tgttggtttc
      121 tcattgtttt taagcctact ggagcaataa agtttgaaga acttttacca ggtttttttt
      181 atcgctgcct tgatatacac ttttcaaaat gctttggtgg gaagaagtag aggactgtta
      241 tgaaagagaa gatgttcaaa agaaaacatt cacaaaatgg gtaaatgcac aattttctaa
      301 gtttgggaag cagcatattg agaacctctt cagtgaccta caggatggga ggcgcctcct
      361 agacctcctc gaaggcctga cagggcaaaa actgccaaaa gaaaaaggat ccacaagagt
      421 tcatgccctg aacaatgtca acaaggcact gcgggttttg cagaacaata atgttgattt
      481 agtgaatatt ggaagtactg acatcgtaga tggaaatcat aaactgactc ttggtttgat
      541 ttggaatata atcctccact ggcaggtcaa aaatgtaatg aaaaatatca tggctggatt
      601 gcaacaaacc aacagtgaaa agattctcct gagctgggtc cgacaatcaa ctcgtaatta
      661 tccacaggtt aatgtaatca acttcaccac cagctggtct gatggcctgg ctttgaatgc
      721 tctcatccat agtcataggc cagacctatt tgactggaat agtgtggttt gccagcagtc
      781 agccacacaa cgactggaac atgcattcaa catcgccaga tatcaattag gcatagagaa
      841 actactcgat cctgaagatg ttgataccac ctatccagat aagaagtcca tcttaatgta
      901 catcacatca ctcttccaag ttttgcctca acaagtgagc attgaagcca tccaggaagt
      961 ggaaatgttg ccaaggccac ctaaagtgac taaagaagaa");
insert into varianti values("Transcript variant Dp140c", "DMD", "Homo sapiens", 7086, "linear mRNA", "1 acactagcaa tggcaaagct ttgtgcggag gcattgctgg ctgctctgaa ctaaaagcat
       61 ccgtggggac cgaaagaggt ttttgcacac cttattaagg aactccagga tggcattggg
      121 cagcggcaaa ctgttgtcag aacattgaat gcaactgggg aagaaataat tcagcaatcc
      181 tcaaaaacag atgccagtat tctacaggaa aaattgggaa gcctgaatct gcggtggcag
      241 gaggtctgca aacagctgtc agacagaaaa aagaggctag aagaacaaaa gaatatcttg
      301 tcagaatttc aaagagattt aaatgaattt gttttatggt tggaggaagc agataacatt
      361 gctagtatcc cacttgaacc tggaaaagag cagcaactaa aagaaaagct tgagcaagtc
      421 aagttactgg tggaagagtt gcccctgcgc cagggaattc tcaaacaatt aaatgaaact
      481 ggaggacccg tgcttgtaag tgctcccata agcccagaag agcaagataa acttgaaaat
      541 aagctcaagc agacaaatct ccagtggata aaggtttcca gagctttacc tgagaaacaa
      601 ggagaaattg aagctcaaat aaaagacctt gggcagcttg aaaaaaagct tgaagacctt
      661 gaagagcagt taaatcatct gctgctgtgg ttatctccta ttaggaatca gttggaaatt
      721 tataaccaac caaaccaaga aggaccattt gacgttaagg aaactgaaat agcagttcaa
      781 gctaaacaac cggatgtgga agagattttg tctaaagggc agcatttgta caaggaaaaa
      841 ccagccactc agccagtgaa gaggaagtta gaagatctga gctctgagtg gaaggcggta
      901 aaccgtttac ttcaagagct gagggcaaag cagcctgacc tagctcctgg actgaccact
      961 attggagcct ctcctactca gactgttact ctggtgacac");
insert into varianti values("Transcript variant 6", "DMD", "Mus musculus", 1410, "linear mRNA", "1 gccagccagc ggcggctcct ccgcagtgct ttcggctgcg agcctgggcg gcggcgcttg
       61 actttcgggg agccccgtgg cttgggcaag cttactcctc cgctctaagc gtccgcccct
      121 cactgcctgt gaaaccctta caaccatgag ggaacacctc aaaggccacg agacccaaac
      181 cacttgttgg gaccacccca aaatgacaga gctctaccag tctttagctg acctgaataa
      241 tgtcaggttc tccgcgtata ggactgccat gaagctcaga aggctccaga aggccctttg
      301 cttggatctc ttgagcctgt cagctgcatg tgatgccctg gaccagcaca acctcaagca
      361 aaatgaccag cccatggata tcctgcagat aattaactgt ttgactacaa tttatgatcg
      421 tctggagcaa gagcacaaca atctggtcaa tgtccctctc tgtgtggata tgtgtctcaa
      481 ctggcttctc aatgtttatg atacgggacg aacagggagg atccgtgtcc tgtcttttaa
      541 aactggcatc atttctctgt gtaaagcaca cttggaagac aagtacagat accttttcaa
      601 gcaagtggca agttcaactg gcttttgtga ccagcgtagg ctgggtcttc ttctgcatga
      661 ttctattcaa atcccaagac agttgggtga agttgcttcc tttgggggca gtaacattga
      721 gccgagtgtc aggagctgct tccaatttgc caataataaa cctgagattg aagctgctct
      781 cttccttgac tggatgcgcc tggaacccca gtctatggtg tggctgcccg tcttgcacag
      841 agtggctgct gctgaaactg ccaagcatca agccaagtgt aacatctgta aggagtgtcc
      901 aatcattgga ttcaggtaca gaagcctaaa gcattttaat tatgacatct gccaaagttg
      961 ctttttttct ggccgagttg caaagggcca taaaatgcac");
insert into varianti values("transcript variant 2","TXN", "Homo sapiens", 677, "linear mRNA", "1 gaagctctgt ttggtgcttt ggatccattt ccatcggtcc ttacagccgc tcgtcagact
       61 ccagcagcca agatggtgaa gcagatcgag agcaagactg cttttcagga agccttggac
      121 gctgcaggtg ataaacttgt agtagttgac ttctcagcca cgtggtgtgg gccttgcaaa
      181 atgatcaagc ctttctttca tgatgttgct tcagagtgtg aagtcaaatg catgccaaca
      241 ttccagtttt ttaagaaggg acaaaaggtg ggtgaatttt ctggagccaa taaggaaaag
      301 cttgaagcca ccattaatga attagtctaa tcatgttttc tgaaaatata accagccatt
      361 ggctatttaa aacttgtaat ttttttaatt tacaaaaata taaaatatga agacataaac
      421 ccagttgcca tctgcgtgac aataaaacat taatgctaac actttttaaa accgtctcat
      481 gtctgaatag ctttcaaaat aaatgtgaaa tggtcattta atgtattttc ctatattctc
      541 aatcactttt tagtaacctt gtaggccact gattatttta agattttaaa aattattatt
      601 gctaccttaa tgtattgcta caaaaatctc ttgttggggg caatgcaggt aataaagtag
      661 tatgttgtta tttgtta");
insert into varianti values("transcript variant D","INDY","Drosophila melanogaster",2580,"linear mRNA","1 attcagtcgc gcatttcacc gtttccgaat cggacgaacc gggcgtgctt gctctcctgc
       61 tgctttcgag atcggagtcc cgataaggat ataactacaa cctaaagagg aatccaagcc
      121 tcctcctgcc gctagtttcg aaaagtaaat agagtacttg ttatcaactg ggaagcggag
      181 atacatagct ccgatattcc tgttaaagcc agacaaacgg ataccaacaa acaatcgcca
      241 tatctacacg ccaccgccac tggacatcaa aatggaaatt gaaattggcg aacaacccca
      301 gcctccggtg aagtgctcca acttcttcgc taaccactgg aagggattgg ttgtgttcct
      361 ggtgccgctg ctatgtctgc ctgttatgct gctaaacgaa ggcgccgaat ttcggtgcat
      421 gtacctcctt ttggtaatgg ccatattttg ggttacggaa gccttgcctc tctatgtgac
      481 gtccatgata ccgattgtgg ccttcccaat aatgggtata atgagctcgg atcagacttg
      541 ccgcttgtac ttcaaggata cgctggtgat gttcatgggc ggcattatgg tcgccctggc
      601 tgtggagtac tgtaatctac acaaacgtct tgccttgagg gtaatccaga tcgtgggctg
      661 cagtccccgc agattacact ttggcctcat catggttaca atgtttttga gcatgtggat
      721 ttcgaacgcc gcctgtactg ccatgatgtg tccgattatc caagccgtgc tggaggagct
      781 gcaggctcag ggtgtctgca aaatcaacca tgagcctcaa taccaaatcg ttggaggcaa
      841 caagaaaaac aacgaggatg agccaccata ccccaccaag atcactctgt gctactatct
      901 gggcattgcc tacgcctcct cgctgggtgg ctgtggaacc atcatcggaa ctgccaccaa
      961 tcttaccttc aagggcatct acgaggctcg tttcaagaac");
insert into varianti values("transcript variant A","INDY","Drosophila melanogaster",2481,"linear mRNA","attcagtcgc gcatttcacc gtttccgaat cggacgaacc gggcgtgctt gctctcctgc
       61 tgctttcgag atcggagtcc cgataaggat ataactacaa cctaaagagg aatccaagcc
      121 tcctcctgcc gctagtttcg aaaaatctac acgccaccgc cactggacat caaaatggaa
      181 attgaaattg gcgaacaacc ccagcctccg gtgaagtgct ccaacttctt cgctaaccac
      241 tggaagggat tggttgtgtt cctggtgccg ctgctatgtc tgcctgttat gctgctaaac
      301 gaaggcgccg aatttcggtg catgtacctc cttttggtaa tggccatatt ttgggttacg
      361 gaagccttgc ctctctatgt gacgtccatg ataccgattg tggccttccc aataatgggt
      421 ataatgagct cggatcagac ttgccgcttg tacttcaagg atacgctggt gatgttcatg
      481 ggcggcatta tggtcgccct ggctgtggag tactgtaatc tacacaaacg tcttgccttg
      541 agggtaatcc agatcgtggg ctgcagtccc cgcagattac actttggcct catcatggtt
      601 acaatgtttt tgagcatgtg gatttcgaac gccgcctgta ctgccatgat gtgtccgatt
      661 atccaagccg tgctggagga gctgcaggct cagggtgtct gcaaaatcaa ccatgagcct
      721 caataccaaa tcgttggagg caacaagaaa aacaacgagg atgagccacc ataccccacc
      781 aagatcactc tgtgctacta tctgggcatt gcctacgcct cctcgctggg tggctgtgga
      841 accatcatcg gaactgccac caatcttacc ttcaagggca tctacgaggc tcgtttcaag
      901 aactccaccg aacagatgga cttccccacc ttcatgttct actcggtgcc atccatgttg
      961 gtctacacct tgctgacatt cgtgttcctg caatggcact");
insert into varianti values("transcript variant C","INDY","Drosophila melanogaster",1200,"linear mRNA","1 cacagtgttg cgttttgaaa catcgacagc tatttttttg tcttgctttt tcgcactcgt
       61 tttcattcca atttttgcgc gacttccaat tggaatattg gaatatttct gagagagaaa
      121 ttaaaaagag aacgtaaaac cataacataa ctggacccaa cttagatctg ggttttccat
      181 tgattaccca tttacccgat atatttgact ttattggtca acgatgtgac gctgtggact
      241 cctgactaat catcacacgg atctacacgc caccgccact ggacatcaaa atggaaattg
      301 aaattggcga acaaccccag cctccggtga agtgctccaa cttcttcgct aaccactgga
      361 agggattggt tgtgttcctg gtgccgctgc tatgtctgcc tgttatgctg ctaaacgaag
      421 gcgccgaatt tcggtgcatg tacctccttt tggtaatggc catattttgg gttacggaag
      481 ccttgcctct ctatgtgacg tccatgatac cgattgtggc cttcccaata atgggtataa
      541 tgagctcgga tcagacttgc cgcttgtact tcaaggatac gctggtgatg ttcatgggcg
      601 gcattatggt cgccctggct gtggagtact gtaatctaca caaacgtctt gccttgaggg
      661 taatccagat cgtgggctgc agtccccgca gattacactt tggcctcatc atggttacaa
      721 tgtttttgag catgtggatt tcgaacgccg cctgtactgc catgatgtgt ccgattatcc
      781 aagccgtgct ggaggagctg caggctcagg gtgtctgcaa aatcaaccat gagcctcaat
      841 accaaatcgt tggaggcaac aagaaaaaca acgaggatga gccaccatac cccaccaaga
      901 tcactctgtg ctactatctg ggcattgcct acgcctcctc gctgggtggc tgtggaacca
      961 tcatcggaac tgccaccaat cttaccttca agggcatcta");
      
insert into varianti values("transcript variant X3","GH1","Pan troglodytes",861,"linear mRNA","1 ggggccaggg tataaaaagg gcccacaaga gaccagctca aggatcccaa gacccaactc
       61 cccaaaccac tcagggtcct gtggacagct cacctagctg caatggctcc aggctcccgg
      121 acttcgctgc tcctggcttt tggcctgctc tgcctgccct ggcttcaaga gggcagtgcc
      181 ttcccaacca ttcccttatc caggcttttt gacaatgcta tgctccgcgc ccatcgcctg
      241 caccagctgg cctttgacac ctatcaggag tttgaagaag cctatatccc aaaggaacag
      301 aagtattcat tcctgcagaa cccccagacc tccctctgct tctcagagtc tattccgaca
      361 ccctccaaca gggaggaaac acaacagaaa tccaacctag agctgctccg catctccctg
      421 ctgctcatcc agtcgtggct ggagcccgtg cagttcctca ggagcgtctt cgccaacagc
      481 ctggtgtatg gcgcctcaga cagcaacgtc tatgacctcc taaaggacct agaggaaggc
      541 atccaaacgc tgataggctg gaagatggca gcccccggac tgggcagatc ttcaagcaga
      601 cctacagcaa gtttgacaca aactcacaca accatgacgc actgctcaag aactacgggc
      661 tgctctactg cttcaggaag gacatggaca aggtcgagac attcctgcgc atcgtgcagt
      721 gccgctctgt ggagggcagc tgtggcttct agctgcccgg gtggcatccc tgtgacccct
      781 ccccagtgcc tctcctggcc ctggaagttg ccactccagt gcccaccagc cttgtcctaa
      841 taaaattaag ttgcatcatt t");
      
insert into varianti values("whole genome shotgun sequence","RLN","Felis catus",95154158,"linear DNA","1 cacagtgttg cgttttgaaa catcgacagc tatttttttg tcttgctttt tcgcactcgt
       61 tttcattcca atttttgcgc gacttccaat tggaatattg gaatatttct gagagagaaa
      121 ttaaaaagag aacgtaaaac cataacataa ctggacccaa cttagatctg ggttttccat
      181 tgattaccca tttacccgat atatttgact ttattggtca acgatgtgac gctgtggact
      241 cctgactaat catcacacgg atctacacgc caccgccact ggacatcaaa atggaaattg
      301 aaattggcga acaaccccag cctccggtga agtgctccaa cttcttcgct aaccactgga
      361 agggattggt tgtgttcctg gtgccgctgc tatgtctgcc tgttatgctg ctaaacgaag
      421 gcgccgaatt tcggtgcatg tacctccttt tggtaatggc catattttgg gttacggaag
      481 ccttgcctct ctatgtgacg tccatgatac cgattgtggc cttcccaata atgggtataa
      541 tgagctcgga tcagacttgc cgcttgtact tcaaggatac gctggtgatg ttcatgggcg
      601 gcattatggt cgccctggct gtggagtact gtaatctaca caaacgtctt gccttgaggg
      661 taatccagat cgtgggctgc agtccccgca gattacactt tggcctcatc atggttacaa
      721 tgtttttgag catgtggatt tcgaacgccg cctgtactgc catgatgtgt ccgattatcc
      781 aagccgtgct ggaggagctg caggctcagg gtgtctgcaa aatcaaccat gagcctcaat
      841 accaaatcgt tggaggcaac aagaaaaaca acgaggatga gccaccatac cccaccaaga
      901 tcactctgtg ctactatctg ggcattgcct acgcctcctc gctgggtggc tgtggaacca
      961 tcatcggaac tgccaccaat cttaccttca agggcatcta");

insert into varianti values("exon 5 and partial cds","IL6","Canis",630,"linear DNA","1 ggatgaagtg accactcctg acccaaccac agacgccagc ctgcaggcta tcttgcagtc
       61 gcaggatgag tggctgaagc acacaacaat tcacctcatc ctgcagagtc tggaggattt
      121 cctgcagttc agtctgaggg ctgttcggat aatgtagcct gggcatctaa gattgctgta
      181 gttcatgggc attcctttct ccagtcagaa acctgtgcag tgggcacaaa acttatgttg
      241 ttctctgtga ggaactaaaa gtatgagcgt taggacacta ttttaattat ttttaattta
      301 ttgatattta aatatgtgat atggagttaa tttatataag taatagatat ttatattttt
      361 tatgaagtgc cacttgaaat attttatgta ttcattttga aaaagttaac gtaaaatgct
      421 atgcggcttg aatatcctcg atgtttcgga gccaggtcat ttcttggaat gtgtaggttt
      481 acctcaaata catggctaac ttatgcatat ttttaaaaga aatatttata ctgtgtttat
      541 ataatgttta aattgttttt ataccaataa acaccttttt aaaaaaaaat cagcagctaa
      601 gcctctatgt gtcctgtgaa gcttaatgtg");
     
insert into varianti values("transcript variant X1","TGFB1","Homo sapiens",2783 ,"linear mRNA","1 cacagtgttg cgttttgaaa catcgacagc tatttttttg tcttgctttt tcgcactcgt
       61 tttcattcca atttttgcgc gacttccaat tggaatattg gaatatttct gagagagaaa
      121 ttaaaaagag aacgtaaaac cataacataa ctggacccaa cttagatctg ggttttccat
      181 tgattaccca tttacccgat atatttgact ttattggtca acgatgtgac gctgtggact
      241 cctgactaat catcacacgg atctacacgc caccgccact ggacatcaaa atggaaattg
      301 aaattggcga acaaccccag cctccggtga agtgctccaa cttcttcgct aaccactgga
      361 agggattggt tgtgttcctg gtgccgctgc tatgtctgcc tgttatgctg ctaaacgaag
      421 gcgccgaatt tcggtgcatg tacctccttt tggtaatggc catattttgg gttacggaag
      481 ccttgcctct ctatgtgacg tccatgatac cgattgtggc cttcccaata atgggtataa
      541 tgagctcgga tcagacttgc cgcttgtact tcaaggatac gctggtgatg ttcatgggcg
      601 gcattatggt cgccctggct gtggagtact gtaatctaca caaacgtctt gccttgaggg
      661 taatccagat cgtgggctgc agtccccgca gattacactt tggcctcatc atggttacaa
      721 tgtttttgag catgtggatt tcgaacgccg cctgtactgc catgatgtgt ccgattatcc
      781 aagccgtgct ggaggagctg caggctcagg gtgtctgcaa aatcaaccat gagcctcaat
      841 accaaatcgt tggaggcaac aagaaaaaca acgaggatga gccaccatac cccaccaaga
      901 tcactctgtg ctactatctg ggcattgcct acgcctcctc gctgggtggc tgtggaacca
      961 tcatcggaac tgccaccaat cttaccttca agggcatcta");


delete from studicompletati where nomericerca != "";
insert into studicompletati values("The complete sequence of dystrophin predicts a rod-shaped cytoskeletal protein", "Complete cds", "DMD", "Homo sapiens");
insert into studicompletati values("The complete sequence of dystrophin predicts a rod-shaped cytoskeletal protein", "Transcript variant 6", "DMD", "Mus musculus");
insert into studicompletati values("Antioxidant Effect of Thioredoxin and Vitamin D3 in Peritoneal Dialysis Patients", "transcript variant 2","TXN", "Homo sapiens");
insert into studicompletati values("Validation and classification of RNA binding proteins identified by mRNA interactome capture", "transcript variant 2","TXN", "Homo sapiens");
insert into studicompletati values("Gene Model Annotations for Drosophila melanogaster: The Rule-Benders", "transcript variant A", "INDY", "Drosophila melanogaster");
insert into studicompletati values("Gene Model Annotations for Drosophila melanogaster: The Rule-Benders", "transcript variant C", "INDY", "Drosophila melanogaster");
insert into studicompletati values("Imbalance in thioredoxin system activates NLRP3 inflammasome pathway in epicardial adipose tissue of patients with coronary artery disease", "transcript variant 2","TXN", "Homo sapiens");
insert into studicompletati values("Imbalance in thioredoxin system activates NLRP3 inflammasome pathway in epicardial adipose tissue of patients with coronary artery disease", "transcript variant X1","TGFB1", "Homo sapiens");
insert into studicompletati values("Compensatory Protection of Thioredoxin-Deficient Cells from Etoposide-Induced Cell Death", "transcript variant 2","TXN", "Homo sapiens");
insert into studicompletati values("Compensatory Protection of Thioredoxin-Deficient Cells from Etoposide-Induced Cell Death", "whole genome shotgun sequence","RLN", "Felis catus");
insert into studicompletati values("Secretion of thioredoxin by normal and neoplastic cells through a leaderless secretory pathway", "transcript variant 2","TXN", "Homo sapiens");
insert into studicompletati values("Complete cloning of the Duchenne muscular dystrophy (DMD) cDNA", "Complete cds","DMD", "Homo sapiens");
insert into studicompletati values("Gene Model Annotations for Drosophila melanogaster: Impact of High-Throughput Data", "transcript variant D", "INDY", "Drosophila melanogaster");
insert into studicompletati values("Conservation of the Duchenne muscular dystrophy gene in mice and humans", "Complete cds","DMD", "Homo sapiens");
insert into studicompletati values("Conservation of the Duchenne muscular dystrophy gene in mice and humans", "Transcript variant 6","DMD", "Mus musculuss");
insert into studicompletati values("The Release 6 reference sequence of the Drosophila melanogaster genome", "transcript variant D", "INDY", "Drosophila melanogaster");
insert into studicompletati values("The Release 6 reference sequence of the Drosophila melanogaster genome", "transcript variant C", "INDY", "Drosophila melanogaster");
insert into studicompletati values("The Release 6 reference sequence of the Drosophila melanogaster genome", "transcript variant A", "INDY", "Drosophila melanogaster");
insert into studicompletati values("The primary structure of monkey pituitary growth hormone", "transcript variant X3", "GH1", "Pan troglodytes");
insert into studicompletati values("Gene conversions in the growth hormone gene family of primates: stronger homogenizing effects in the Hominidae lineage", "transcript variant X3", "GH1", "Pan troglodytes");
insert into studicompletati values("Gene conversions in the growth hormone gene family of primates: stronger homogenizing effects in the Hominidae lineage", "transcript variant X1", "TGFB1", "Homo sapiens");
insert into studicompletati values("High Prevalence of Nonalcoholic Fatty Liver Disease Among Adolescents and Young Adults With Hypopituitarism due to Growth Hormone Deficiency", "transcript variant X1", "TGFB1", "Homo sapiens");
insert into studicompletati values("Growth hormone-related genes from baboon (Papio hamadryas): Characterization, placental expression and evolutionary aspects", "transcript variant X3", "GH1", "Pan troglodytes");
insert into studicompletati values("Mutations in GH1 gene and isolated growth hormone deficiency", "transcript variant X3", "GH1", "Pan troglodytes");
insert into studicompletati values("Adaptive genic evolution in the Drosophila genomes", "transcript variant A", "INDY", "Drosophila melanogaster");
insert into studicompletati values("Mitochondrial DNA sequence evolution and phylogeny in the genus Mus", "Transcript variant 6", "DMD", "Mus musculus");
insert into studicompletati values("Identification of a new copper metabolism gene by positional cloning in a purebred dog population", "exon 5 and partial cds", "IL6", "Canis");
insert into studicompletati values("Detection and characterization of interleukin-6 gene variants in Canis familiaris: Association studies with periodontal disease", "exon 5 and partial cds", "IL6", "Canis");





DROP TRIGGER IF EXISTS chiudi_studio;
delete from studi where nomericerca != "";

DELIMITER $$
CREATE TRIGGER chiudi_studio
BEFORE DELETE on studi
FOR EACH ROW
BEGIN
	INSERT INTO studicompletati(nomericerca, nomevariante, idgene, idorganismo) 
    values(OLD.nomericerca,OLD.nomevariante, OLD.idgene, OLD.idorganismo);
END$$
DELIMITER ;

insert into studi values("A public genome-scale lentiviral expression library of human ORFs", "transcript variant 2","TXN", "Homo sapiens");

insert into studi values("14-3-3zeta Constrains insulin secretion by regulating mitochondrial function in pancreatic beta cells", "transcript variant X1", "TGFB1", "Homo sapiens");
insert into studi values("The prognostic value of galactosylceramide-sulfotransferase (Gal3ST1) in human renal cell carcinoma", "transcript variant 2","TXN", "Homo sapiens");
insert into studi values("A3 receptor ligands: past, present and future trends", "transcript variant 2","TXN", "Homo sapiens");
insert into studi values("Cancer-associated alternative usage of multiple promoters of human GalCer sulfotransferase gene", "whole genome shotgun sequence","RLN", "Felis catus");
insert into studi values("Dystrophin cytochemistry in mdx mouse muscles injected with labeled normal myoblasts", "Transcript variant 6", "DMD", "Mus musculus");
insert into studi values("G protein-coupled receptors and adipogenesis: a focus on adenosine receptors", "Complete cds", "DMD", "Homo sapiens");
insert into studi values("Inferring nonneutral evolution from human-chimp-mouse orthologous gene trios", "transcript variant X1", "TGFB1", "Homo sapiens");
insert into studi values("Molecular Phylogeny and Dating of Early Primate Divergences", "transcript variant X3", "GH1", "Pan troglodytes");
insert into studi values("Novel alleles of the TGFB1 regulatory region and exon 1", "transcript variant X3", "GH1", "Pan troglodytes");


delete from condizioniassociate where nome != "";
insert into condizioniassociate values("Duchenne muscular dystrophy");
insert into condizioniassociate values("Becker muscular dystrophy");
insert into condizioniassociate values("Pituitary dwarfism");


delete from manifestazioni where condizione != "";
insert into manifestazioni values("Duchenne muscular dystrophy","DMD", "Homo sapiens");
insert into manifestazioni values("Becker muscular dystrophy","DMD", "Homo sapiens");
insert into manifestazioni values("Duchenne muscular dystrophy","DMD", "Mus musculus");
insert into manifestazioni values("Pituitary dwarfism","GH1", "Pan troglodytes");
insert into manifestazioni values("Pituitary dwarfism","TGFB1", "Homo sapiens");


delete from cds where intervallo != "";
insert into cds values("103..677", "Complete cds", "DMD", "Homo sapiens");
insert into cds values("900..999", "Complete cds", "DMD", "Homo sapiens");







