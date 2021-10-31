-- Cerintele 11-16 - > Bejan-Topse Lucian-COsmin [211]

-- Cerinta 11 - subpuncte de acoperit:
-- x operație join pe cel puțin 4 tabele -
-- x filtrare la nivel delinii (where)-
-- x subcereri sincronizateîn care intervin cel puțin 3 tabele
-- x subcereri nesincronizateîn care intervin cel puțin 3 tabele
-- x grupări de date, funcții grup, filtrare la nivel degrupuri
-- x ordonări -
-- x utilizarea a cel puțin 2 funcții pe șiruri de caractere, x 2 funcții pe date calendaristice, x a funcțiilor NVL și DECODE, a cel puțin unei expresii CASE
-- x utilizarea a cel puțin 1 bloc de cerere(clauza WITH)


-- EX1. Join 4 tabele, group by, order by, count. -> Sa se afiseze toti parasutistii care au sarit la eveniment,
--  de cate ori au sarit, cate salturi totale au ( si doar cei cu mai mult de 500 de salturi totale) , ce rank au si de la ce aerodrom au venit. Ordonat crescator dupa nr total de salturi.
select s.ID_skydiver, count(sf.ID_skydiver) as nr_local_jumps,nr_jumps, rank_name, Aerodrome_name
from skydiver s join skydiver_flights sf using (ID_skydiver)
	join ranks using (ID_rank) 
    join aerodrome using (ID_aerodrome)
group by s.ID_skydiver
having nr_jumps >500
order by nr_jumps asc;




-- EX2. -> ifnull ( nvl ), subcerere sincronizata cu 3 tabele , operatii cu siruri -> Din tabelul de salturi sa se afiseze pentru parasutistii din aerodromul cu id 1005 
-- primul char din prenume + '-' + primele 2 caractere din numele lor, 
-- apoi prenumele lor cu litere mari, si numele de familie daca se termina cu 'escu' iar in caz contrar se va afisa 'no escu', id ul parasutei cu care au sarit, id ul zborului
-- si review ul lasat, daca nu exista se va afisa 'no review';

select concat_ws('-',left(first_name,1), left(last_name,2)) as "init",
		UCASE(first_name) as 'name',
        if(instr(last_name,'scu' )=0,"no escu",last_name) as 'escu?',
        ID_parachute, 
        ID_flight, 
        ifnull(review ,'no review') as 'review'
from skydiver_flights sf join skydiver using( ID_skydiver)
where exists ( select * 
			from skydiver join aerodrome using (ID_aerodrome)
            where ID_skydiver= sf.ID_skydiver and ID_aerodrome = 1005) 
order by ID_flight;
            
-- EX3. -> subcerere asincronizata cu 3 tabele, exercitiul de mai sus 

select concat_ws('-',left(first_name,1), left(last_name,2)) as "init",
		UCASE(first_name) as 'name',
        if(instr(last_name,'scu' )=0,"no escu",last_name) as 'escu?',
        ID_parachute, 
        ID_flight, 
        ifnull(review ,'no review') as 'review'
from skydiver_flights join skydiver using( ID_skydiver)
where ID_skydiver in ( select ID_skydiver 
			from skydiver join aerodrome using (ID_aerodrome)
            where ID_skydiver is not null and ID_aerodrome = 1005) 
order by ID_flight;
    
-- EX4. date functions-> Pentru fiecare iesire cu avionul se va preciza id_ul zborului, 
-- partea zilei (ora 12- mid day, <12 morning, >12 noon) si data completa in formatul ZI-Luna-An

select ID_flights, 
case when hour(date) = 12 then "mid day"
	when hour(date) > 12 then "noon"
    when hour(date) < 12 then "morning"
    else "nothing"
    end as part_of_day,
    date_format(date,'%W %M %Y') as data
from flights;

-- EX5. clausa with, o functie date -> Sa se afiseze id avion, id zbor si data zborurilor din ziua de 30 care aveau camera montata de la firma 'GoPro'.
with avioane as (select * 
	from flights join plane using(ID_plane)
	where day(date)=30)
select ID_plane, ID_flights, date, company
from avioane join camera using (ID_camera)
where company = 'gopro';




-- Cerinta 12:Implementarea a 3 operații de actualizare sau suprimare a datelor utilizând subcereri.

-- 1) V-om adauga o coloana noua in skydiver: "jumps_ev". 
-- Sa se insereze in noul camp din tabel numarul de salturi pe care le a facut fiecare parasutist la eveniment.

alter table `skydiving_event`.`skydiver` 
add column `jump_ev` int not null after `ID_boss`;

 CREATE TABLE skydiver_aux AS SELECT * FROM skydiver;

drop table skydiver_aux;

update skydiver
set jump_ev = (
		select count(sf.ID_skydiver)
		from  skydiver_flights sf
        where skydiver.ID_skydiver = sf.ID_skydiver
        );
rollback;
select * from skydiver; 

alter table `skydiving_event`.`skydiver` 
drop column `jump_ev`;



-- 2) toti parasutitii din constanta si-au schimbat adresele de mail si acestea trebuie de modificat in baza de date.
-- din fericire este simplu, acestia si au pastrat numele de utilizator, si si-au schimbat doar compania de mail, de la gmail la yahoo
-- practic exemplu@gmail.com -> exemplu@yahoo.com 

-- CREATE TABLE skydiver_aux AS SELECT * FROM skydiver;
 
update skydiver 
set mail =  replace(mail, '@gmail.com','@yahoo.com')	
where ID_aerodrome in (
		select ID_aerodrome from aerodrome 
        where Aerodrome_city='Constanta'
);

rollback;
select * from skydiver
order by ID_aerodrome; -- 1011 si 1012 sunt din constanta

-- 3) A aparut o lege nestiuta pana acum. Un pilot poate da un review unui avion doar daca are peste 500 de ore de zbor. 
-- se cere sa se stearga din tabelul testing liniile cu testele pilotilor cu mai putin de 500 de ore de zbor.

delete from testing
where ID_pilot = any(select ID_pilot from pilot where hours_flight<500);

rollback;

select * from testing
order by ID_pilot;  -- pilotul cu id 16 avea 480 de ore de zbor


-- Cerinta 13: Crearea unei secvențe ce va fi utilizată în inserarea înregistrărilor în tabele(punctul 10).

-- in crearea tabelului camera am folosit auto-increment

-- CREATE TABLE `camera` (
--   `ID_camera` int NOT NULL AUTO_INCREMENT,
--   `frequency` int NOT NULL,
--   `company` varchar(45) NOT NULL,
--   PRIMARY KEY (`ID_camera`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=10111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from camera;

insert into `skydiving_event`.`camera` (`frequency`, `company`) values ('55', 'Martian'); -- merge pt ca are auto increment si nu e nevoie sa trecem si id ul
-- insert into `skydiving_event`.`aerodrome` (`Aerodrome_name`, `Aerodrome_city`) values ('GiulestiSky', 'Giulesti'); -- nu merge pt ca nu are auto increment

-- Cerinta 14: Sa se creeze o vizulizare cu toate informatiile despre pilotii cu mai mult de 600 de ore de zbor, incluziv informatiile aerodromurilor de unde vin.

create or replace view view_pilot as
select p.ID_pilot, p.first_name, p.last_name, p.age, p.hours_flight, p.mail, p.ID_aerodrome, a.Aerodrome_city, a.Aerodrome_name
from pilot p join aerodrome a using (ID_aerodrome)
where p.hours_flight >600
with check option;

select * from view_pilot;

-- acest insert este permis deoarece se modfica doar atributele din tabelul cheii primare, mai exact doar campurile din pilot 
insert into view_pilot (ID_pilot, first_name, last_name, age, hours_flight, mail, ID_aerodrome) 
values (18,'Denis', 'Tomescu',60, 601,'d_t@gmail.com', 1002);
rollback;

-- acest insert nu este permis deoarece in creea viewului am specificat 'with check option' si astfel nu putem introduce piloti cu mai putin de 601 ore de zbor
-- insert into view_pilot (ID_pilot, first_name, last_name, age, hours_flight, mail, ID_aerodrome) 
-- values (18,'Denis', 'Tomescu',60, 600,'d_t@gmail.com', 1002);
-- rollback;

-- acest insert nu este permis deoarece apar campuri din tabelul aerodrome, care de altfel nu pot fi adaugate. 
-- chiar daca vizualizarea este compusa, cheia primara este cea din pilot si astfel nu se pot adauga atribute din aerodrome
-- insert into view_pilot (ID_pilot, first_name, last_name, age, hours_flight, mail, ID_aerodrome, Aerodrome_name, Aerodome_city) 
-- values (18,'Denis', 'Tomescu',60, 600,'d_t@gmail.com', 1002, 'BacauZbor', 'Bacau');
-- rollback;

select * from view_pilot;

select * from pilot;

select *  from skydiver_flights;

-- 15. Crearea  unui  index  care  să optimizeze  o  cerere  de  tip  căutare  cu  2  criterii.  Specificați cererea.

-- am creat un index full_name pentru coloanele last_name si first_name din skydiver.
-- aceasta va actiona ijn selecturile cu last_name /  first_name sau cu amandoua
create index full_name
on skydiver (last_name,first_name);


show index from skydiver;

select first_name, last_name, mail
from skydiver
where last_name = 'Popescu';

explain select first_name, last_name, mail
from skydiver
where last_name = 'Popescu';

select first_name, last_name, mail
from skydiver
where last_name = 'Popescu' and first_name = 'Daniel';

explain select first_name, last_name, mail
from skydiver
where last_name = 'Popescu' and first_name = 'Daniel';


-- 16  Formulați în limbaj natural și implementați în SQL: o cerere ce utilizează operația outer-join pe minimum 4 tabele și două cereri ce utilizează operația division.

-- Ex1. - Division-> Sa se afiseze codurile tuturor pilotilor care au testat toate avioanele cu modelul 'TeslaS'. (Am folosit division cu count)
-- (in cazul de fata ar trebui sa apara id urile tuturor pilotilor, deoarece toti pilotii au verificat toate avioanele.
--  Dar se pot sterge anumite randuri pentru a se verifica daca dispar dina fisare pilotii stersi)
use skydiving_event;

select ID_pilot 
from testing
where ID_plane in(
	Select ID_plane from plane 
    where Model = 'TeslaS'
)
group by ID_pilot
having count(ID_plane) = (select count(*) from plane where model = 'TeslaS')
;

-- EX2. - Division-> Sa se afiseze codurile tuturor pilotilor care au testat toate avioanele cu modelul 'TeslaX'. (Am folosit not exists)

-- delete from testing where ID_plane = 2 and ID_pilot = 10;
-- delete from testing where ID_plane = 4 and ID_pilot = 11;  pentru test

select distinct ID_pilot 
from testing t
where not exists(
	select * 
    from plane p 
    where model = 'TeslaX' and not exists ( 
				select 'x' 
                from testing t2 
                where p.ID_plane = t2.ID_plane and t2.ID_pilot = t.ID_pilot
                ) 
    );

rollback;

-- INSERT INTO `skydiving_event`.`testing` (`ID_plane`, `ID_pilot`, `time`, `review`) VALUES ('2', '10', '20', 'perfect');
-- INSERT INTO `skydiving_event`.`testing` (`ID_plane`, `ID_pilot`, `time`, `review`) VALUES ('4', '11', '20', 'perfect');

-- EX3 - outer join -> Sa se afiseze pentru fiecare parasutist numele prenumele, numarul de salturi pe care le-a executat, 
-- rank-ul pe care il are, din ce oras a venit si ID_ul bossului, daca nu are boss se va afisa 'no boss present;

select s1.ID_skydiver, s1.last_name, s1.first_name, count(sf.ID_skydiver) as 'nr salturi' , rank_name, aerodrome_city, ifnull(s2.ID_skydiver, 'no boss present') as boss
from skydiver s1 left outer join skydiver_flights sf on (s1.ID_skydiver = sf.ID_skydiver)
	join ranks using ( ID_rank)
    join aerodrome using (ID_aerodrome)
    left outer join skydiver s2 on (s1.ID_boss = s2.ID_skydiver)
group by s1.ID_skydiver
order by s1.ID_skydiver;





        










