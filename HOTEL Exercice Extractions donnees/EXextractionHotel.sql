USE hotel;


/* 1 - Liste hotels*/
SELECT hot_nom, hot_ville FROM hotel;

/* 2 - Ville residence Mr White */
SELECT cli_ville  FROM client WHERE UPPER (cli_nom)="white" ;

/* 3 - Liste stations altitude <1000 */
SELECT Sta_nom From station Where sta_altitude < 1000 ;

/* 4 - Liste chambres capacite>1 */
SELECT cha_numero FROM chambre WHERE cha_capacite > 1;

/* 5 - clients n'habitant pas Londres */
SELECT cli_nom, cli_ville From client Where cli_ville <> "Londre";

/* 6 - Liste hotels  ville de Bretou ayant categorie >3 */
SELECT hot_nom, hot_ville, hot_categorie FROM hotel WHERE hot_categorie >3;

/* 7 - Liste hotels avec la station */
SELECT hot_nom, hot_categorie, hot_ville, sta_nom
FROM station 
INNER JOIN hotel ON hot_sta_id=sta_id;
 
/* 8 - Liste chambre et l'hotel */
SELECT hot_nom, hot_categorie, hot_ville, cha_numero
FROM hotel
INNER JOIN chambre ON cha_hot_id=hot_sta_id;

/* 9 - Liste chambres >1 place ville de Bretou */
SELECT hot_nom, hot_categorie, hot_ville, cha_numero, cha_capacite
FROM hotel
INNER JOIN chambre ON cha_hot_id=hot_sta_id;

/* 10 - Liste reservations avec noms clients */
SELECT cli_nom, hot_nom, res_date
FROM client
JOIN hotel ON hot_id=cli_id
JOIN reservation ON res_cli_id=cli_id;

