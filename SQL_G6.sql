--- retreiving all the files:

Select * from urban;
Select * from rural;
Select * from total;
Select * from nuclear;
Select * from oil;
Select * from renewable;
Select * from losses;

---- Joining Metadata and Data file to Combine Region and Incomegroup in the table:


select * into rural_combo from (select A.*, B.Region, B.IncomeGroup from rural as A inner join Metadata as B 
on A.Country_Code = B.Country_Code)A;

select * into urban_combo from (select A.*, B.Region, B.IncomeGroup from urban as A inner join Metadata as B 
on A.Country_Code = B.Country_Code)A;

select * into total_combo from (select A.*, B.Region, B.IncomeGroup from total as A inner join Metadata as B 
on A.Country_Code = B.Country_Code)A;

select * into oil_combo from (select A.*, B.Region, B.IncomeGroup from oil as A inner join Metadata as B 
on A.Country_Code = B.Country_Code)A;

select * into nuclear_combo from (select A.*, B.Region, B.IncomeGroup from nuclear as A inner join Metadata as B 
on A.Country_Code = B.Country_Code)A;

select * into renewable_combo from (select A.*, B.Region, B.IncomeGroup from renewable as A inner join Metadata as B 
on A.Country_Code = B.Country_Code)A;

select * into losses_combo from (select A.*, B.Region, B.IncomeGroup from losses as A inner join Metadata as B 
on A.Country_Code = B.Country_Code)A;

-----Final datafiles to work:

select * from rural_combo
select * from urban_combo
select * from total_combo
select * from oil_combo
select * from nuclear_combo
select * from renewable_combo
select * from losses_combo


----Droping the null row:

delete from rural_combo
where Country_Name = 'American Samoa';
delete from urban_combo
where Country_Name = 'American Samoa';
delete from total_combo
where Country_Name = 'American Samoa';


--


------ avg access of electricity post 2000s - Country  wise

---- Rural
---Method-1
select s1.Country_Name , n/d as Avg_2000s_Rural  from (
	select  Country_Name, sum(
	+ isnull(Y_2001,0) + isnull(Y_2002,0) + isnull(Y_2003,0) + isnull(Y_2004,0) + isnull(Y_2005,0)
	+ isnull(Y_2006,0) + isnull(Y_2007,0) + isnull(Y_2008,0) + isnull(Y_2009,0) + isnull(Y_2010,0)
	+ isnull(Y_2011,0) + isnull(Y_2012,0) + isnull(Y_2013,0) + isnull(Y_2014,0) + isnull(Y_2015,0)
	+ isnull(Y_2016,0) + isnull(Y_2017,0) + isnull(Y_2018,0) + isnull(Y_2019,0) + isnull(Y_2020,0)) as n ,
	(count(Y_2001) + count(Y_2002) + count(Y_2003)+ count(Y_2004) 
	+ count(Y_2005) + count(Y_2006) + count(Y_2007) + count(Y_2008) + count(Y_2009) + count(Y_2010)+ count(Y_2011) 
	+ count(Y_2012) + count(Y_2013) + count(Y_2014) + count(Y_2015) + count(Y_2016) + count(Y_2017)+ count(Y_2018) 
	+ count(Y_2019) + count(Y_2020)	) as d 
	from rural_combo where Region is not null
	group by Country_Name
	) as s1 
	where s1.d != 0 order by Avg_2000s_Rural desc

---Method-2
Select Country_Name , Avg(Production) as Avg_rural_Prod from (select Country_Name  , [Year], Production 
from (Select Country_Name ,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from rural_combo where region is not null )aa
unpivot 
(production for [Year] in ([Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where Country_Name is not null group by Country_Name order by Avg_rural_Prod desc


--- Urban
---Method-1
select s1.Country_Name , n/d as Avg_2000s_Urban  from (
	select  Country_Name, sum(
	+ isnull(Y_2001,0) + isnull(Y_2002,0) + isnull(Y_2003,0) + isnull(Y_2004,0) + isnull(Y_2005,0)
	+ isnull(Y_2006,0) + isnull(Y_2007,0) + isnull(Y_2008,0) + isnull(Y_2009,0) + isnull(Y_2010,0)
	+ isnull(Y_2011,0) + isnull(Y_2012,0) + isnull(Y_2013,0) + isnull(Y_2014,0) + isnull(Y_2015,0)
	+ isnull(Y_2016,0) + isnull(Y_2017,0) + isnull(Y_2018,0) + isnull(Y_2019,0)) as n ,
	(count(Y_2001) + count(Y_2002) + count(Y_2003)+ count(Y_2004) 
	+ count(Y_2005) + count(Y_2006) + count(Y_2007) + count(Y_2008) + count(Y_2009) + count(Y_2010)+ count(Y_2011) 
	+ count(Y_2012) + count(Y_2013) + count(Y_2014) + count(Y_2015) + count(Y_2016) + count(Y_2017)+ count(Y_2018) 
	+ count(Y_2019)) as d 
	from urban_combo where Region is not null
	group by Country_Name
	) as s1 
	where s1.d != 0 order by Avg_2000s_Urban desc

---Method-2
Select Country_Name , Avg(Production) as Avg_urban_Prod from (select Country_Name  , [Year], Production 
from (Select Country_Name ,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from urban_combo where region is not null )aa
unpivot 
(production for [Year] in ([Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where Country_Name is not null group by Country_Name order by Avg_urban_Prod desc



-----Total

---Method-1
select s1.Country_Name , n/d as Avg_2000s_Total  from (
	select  Country_Name, sum(
	+ isnull(Y_2001,0) + isnull(Y_2002,0) + isnull(Y_2003,0) + isnull(Y_2004,0) + isnull(Y_2005,0)
	+ isnull(Y_2006,0) + isnull(Y_2007,0) + isnull(Y_2008,0) + isnull(Y_2009,0) + isnull(Y_2010,0)
	+ isnull(Y_2011,0) + isnull(Y_2012,0) + isnull(Y_2013,0) + isnull(Y_2014,0) + isnull(Y_2015,0)
	+ isnull(Y_2016,0) + isnull(Y_2017,0) + isnull(Y_2018,0) + isnull(Y_2019,0)) as n ,
	(count(Y_2001) + count(Y_2002) + count(Y_2003)+ count(Y_2004) 
	+ count(Y_2005) + count(Y_2006) + count(Y_2007) + count(Y_2008) + count(Y_2009) + count(Y_2010)+ count(Y_2011) 
	+ count(Y_2012) + count(Y_2013) + count(Y_2014) + count(Y_2015) + count(Y_2016) + count(Y_2017)+ count(Y_2018) 
	+ count(Y_2019)) as d 
	from total_combo where Region is not null
	group by Country_Name
	) as s1 
	where s1.d != 0 order by Avg_2000s_Total desc

---Method-2
Select Country_Name , Avg(Production) as Avg_total_Prod from (select Country_Name  , [Year], Production 
from (Select Country_Name ,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from total_combo where region is not null )aa
unpivot 
(production for [Year] in ([Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where Country_Name is not null group by Country_Name order by Avg_total_Prod desc


------ Catgroy Wise Access To electricity:
---Method-1
select s1.Country_Name , n/d as Avg_2000s_Total  from (
	select  Country_Name, sum(
	+ isnull(Y_2001,0) + isnull(Y_2002,0) + isnull(Y_2003,0) + isnull(Y_2004,0) + isnull(Y_2005,0)
	+ isnull(Y_2006,0) + isnull(Y_2007,0) + isnull(Y_2008,0) + isnull(Y_2009,0) + isnull(Y_2010,0)
	+ isnull(Y_2011,0) + isnull(Y_2012,0) + isnull(Y_2013,0) + isnull(Y_2014,0) + isnull(Y_2015,0)
	+ isnull(Y_2016,0) + isnull(Y_2017,0) + isnull(Y_2018,0) + isnull(Y_2019,0)) as n ,
	(count(Y_2001) + count(Y_2002) + count(Y_2003)+ count(Y_2004) 
	+ count(Y_2005) + count(Y_2006) + count(Y_2007) + count(Y_2008) + count(Y_2009) + count(Y_2010)+ count(Y_2011) 
	+ count(Y_2012) + count(Y_2013) + count(Y_2014) + count(Y_2015) + count(Y_2016) + count(Y_2017)+ count(Y_2018) 
	+ count(Y_2019)) as d 
	from total_combo where Region is null
	group by Country_Name
	) as s1 
	where s1.d != 0 order by Avg_2000s_Total desc

---Method-2
Select Country_Name , Avg(Production) as Avg_total_Prod from (select Country_Name  , [Year], Production 
from (Select Country_Name ,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from total_combo where region is null )aa
unpivot 
(production for [Year] in ([Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where Country_Name is not null group by Country_Name order by Avg_total_Prod desc



----Table formation Avg_2000s


select * into Avg_2000s_Rural from (select s1.Country_Name , n/d as Avg_2000s_Rural  from (
	select  Country_Name, sum(
	+ isnull(Y_2001,0) + isnull(Y_2002,0) + isnull(Y_2003,0) + isnull(Y_2004,0) + isnull(Y_2005,0)
	+ isnull(Y_2006,0) + isnull(Y_2007,0) + isnull(Y_2008,0) + isnull(Y_2009,0) + isnull(Y_2010,0)
	+ isnull(Y_2011,0) + isnull(Y_2012,0) + isnull(Y_2013,0) + isnull(Y_2014,0) + isnull(Y_2015,0)
	+ isnull(Y_2016,0) + isnull(Y_2017,0) + isnull(Y_2018,0) + isnull(Y_2019,0) + isnull(Y_2020,0)) as n ,
	(count(Y_2001) + count(Y_2002) + count(Y_2003)+ count(Y_2004) 
	+ count(Y_2005) + count(Y_2006) + count(Y_2007) + count(Y_2008) + count(Y_2009) + count(Y_2010)+ count(Y_2011) 
	+ count(Y_2012) + count(Y_2013) + count(Y_2014) + count(Y_2015) + count(Y_2016) + count(Y_2017)+ count(Y_2018) 
	+ count(Y_2019) + count(Y_2020)	) as d 
	from rural_combo where Region is not null
	group by Country_Name
	) as s1 
	where s1.d != 0)AA




select * into Avg_2000s_Urban from (select s1.Country_Name , n/d as Avg_2000s_Urban  from (
	select  Country_Name, sum(
	+ isnull(Y_2001,0) + isnull(Y_2002,0) + isnull(Y_2003,0) + isnull(Y_2004,0) + isnull(Y_2005,0)
	+ isnull(Y_2006,0) + isnull(Y_2007,0) + isnull(Y_2008,0) + isnull(Y_2009,0) + isnull(Y_2010,0)
	+ isnull(Y_2011,0) + isnull(Y_2012,0) + isnull(Y_2013,0) + isnull(Y_2014,0) + isnull(Y_2015,0)
	+ isnull(Y_2016,0) + isnull(Y_2017,0) + isnull(Y_2018,0) + isnull(Y_2019,0)) as n ,
	(count(Y_2001) + count(Y_2002) + count(Y_2003)+ count(Y_2004) 
	+ count(Y_2005) + count(Y_2006) + count(Y_2007) + count(Y_2008) + count(Y_2009) + count(Y_2010)+ count(Y_2011) 
	+ count(Y_2012) + count(Y_2013) + count(Y_2014) + count(Y_2015) + count(Y_2016) + count(Y_2017)+ count(Y_2018) 
	+ count(Y_2019)) as d 
	from urban_combo where Region is not null
	group by Country_Name
	) as s1 
	where s1.d != 0)AA


select * into Avg_2000s_Total from (select s1.Country_Name , n/d as Avg_2000s_Total  from (
	select  Country_Name, sum(
	+ isnull(Y_2001,0) + isnull(Y_2002,0) + isnull(Y_2003,0) + isnull(Y_2004,0) + isnull(Y_2005,0)
	+ isnull(Y_2006,0) + isnull(Y_2007,0) + isnull(Y_2008,0) + isnull(Y_2009,0) + isnull(Y_2010,0)
	+ isnull(Y_2011,0) + isnull(Y_2012,0) + isnull(Y_2013,0) + isnull(Y_2014,0) + isnull(Y_2015,0)
	+ isnull(Y_2016,0) + isnull(Y_2017,0) + isnull(Y_2018,0) + isnull(Y_2019,0) + isnull(Y_2020,0)) as n ,
	(count(Y_2001) + count(Y_2002) + count(Y_2003)+ count(Y_2004) 
	+ count(Y_2005) + count(Y_2006) + count(Y_2007) + count(Y_2008) + count(Y_2009) + count(Y_2010)+ count(Y_2011) 
	+ count(Y_2012) + count(Y_2013) + count(Y_2014) + count(Y_2015) + count(Y_2016) + count(Y_2017)+ count(Y_2018) 
	+ count(Y_2019) + count(Y_2020)	) as d 
	from total_combo where Region is not null
	group by Country_Name
	) as s1 
	where s1.d != 0)AA



select * from Avg_2000s_Total
select * from Avg_2000s_Rural
select * from Avg_2000s_Urban


-----Income group wise comparision post 2000s

-----Total
---Method-1
Select IncomeGroup, Avg(Avg_2000s_Total) as Avg_post_2000s_Total from ( select A.TableName , A.IncomeGroup , B.Avg_2000s_Total from Metadata as A inner join Avg_2000s_Total as B on
A.TableName = B.Country_Name)A where incomegroup is not null group by IncomeGroup order by Avg_post_2000s_Total desc;

---Method-2
Select IncomeGroup , Avg(Production) as Avg_total_Prod from (select IncomeGroup  , [Year], Production 
from (Select IncomeGroup ,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from total_combo where region is not null )aa
unpivot 
(production for [Year] in ([Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where IncomeGroup is not null group by IncomeGroup order by Avg_total_Prod desc


----Rural
---Method-1
Select IncomeGroup, Avg(Avg_2000s_Rural) as Avg_post_2000s_Rural from ( select A.TableName , A.IncomeGroup , B.Avg_2000s_Rural from Metadata as A inner join Avg_2000s_Rural as B on
A.TableName = B.Country_Name)A where incomegroup is not null group by IncomeGroup order by Avg_post_2000s_Rural desc;

---Method-2
Select IncomeGroup , Avg(Production) as Avg_Rural_Prod from (select IncomeGroup  , [Year], Production 
from (Select IncomeGroup ,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from rural_combo where region is not null )aa
unpivot 
(production for [Year] in ([Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where IncomeGroup is not null group by IncomeGroup order by Avg_Rural_Prod desc

---Urban
---Method-1
Select IncomeGroup, Avg(Avg_2000s_Urban) as Avg_post_2000s_Urban from ( select A.TableName , A.IncomeGroup , B.Avg_2000s_Urban from Metadata as A inner join Avg_2000s_Urban as B on
A.TableName = B.Country_Name)A where incomegroup is not null group by IncomeGroup order by Avg_post_2000s_Urban desc;

---Method-2
Select IncomeGroup , Avg(Production) as Avg_Urban_Prod from (select IncomeGroup  , [Year], Production 
from (Select IncomeGroup ,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from rural_combo where region is not null )aa
unpivot 
(production for [Year] in ([Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where IncomeGroup is not null group by IncomeGroup order by Avg_Urban_Prod desc


----Region wise comparision post 2000s

-----Total
Select Region, Avg(Avg_2000s_Total) as Avg_post_2000s_Total from ( select A.TableName , A.Region , B.Avg_2000s_Total from Metadata as A inner join Avg_2000s_Total as B on
A.TableName = B.Country_Name)A where Region is not null group by Region order by Avg_post_2000s_Total desc;

---Urban

Select Region, Avg(Avg_2000s_Urban) as Avg_post_2000s_Urban from ( select A.TableName , A.Region , B.Avg_2000s_Urban from Metadata as A inner join Avg_2000s_Urban as B on
A.TableName = B.Country_Name)A where Region is not null group by Region order by Avg_post_2000s_Urban desc;

---Rural
Select Region, Avg(Avg_2000s_Rural) as Avg_post_2000s_Rural from ( select A.TableName , A.Region , B.Avg_2000s_Rural from Metadata as A inner join Avg_2000s_Rural as B on
A.TableName = B.Country_Name)A where Region is not null group by Region order by Avg_post_2000s_Rural desc;


-----Percentage growth between different decades

Select  Top 20 * , ((Avg_2011_2020 - Avg_2001_2010)/ Avg_2001_2010)*100 as Avg_Growth
from 
(Select A.* ,B.Avg_2011_2020 from (select s1.Country_Name, n/d as Avg_2001_2010  from (
	select  Country_Name, sum(
	+ isnull(Y_2001,0) + isnull(Y_2002,0) + isnull(Y_2003,0) + isnull(Y_2004,0) + isnull(Y_2005,0)
	+ isnull(Y_2006,0) + isnull(Y_2007,0) + isnull(Y_2008,0) + isnull(Y_2009,0) + isnull(Y_2010,0)) as n ,
	(count(Y_2001) + count(Y_2002) + count(Y_2003)+ count(Y_2004) 
	+ count(Y_2005) + count(Y_2006) + count(Y_2007) + count(Y_2008) + count(Y_2009) + count(Y_2010)) as d 
	from total_combo where Region is not null
	group by Country_Name
	) as s1
	where s1.d != 0) as A inner join
(select s2.Country_Name, p/q as Avg_2011_2020  from (
	select  Country_Name, sum(isnull(Y_2011,0) + isnull(Y_2012,0) + isnull(Y_2013,0) + isnull(Y_2014,0) + isnull(Y_2015,0)
	+ isnull(Y_2016,0) + isnull(Y_2017,0) + isnull(Y_2018,0) + isnull(Y_2019,0)) as p ,
	(count(Y_2011) + count(Y_2012) + count(Y_2013) + count(Y_2014) + count(Y_2015) + count(Y_2016) + count(Y_2017)+ count(Y_2018) + count(Y_2019)) as q 
	from total_combo where Region is not null
	group by Country_Name
	) as s2
	where s2.q != 0) as B on
	A.country_Name = B.Country_Name)AA
	where Avg_2001_2010 >30 order by Avg_Growth Desc;


----Q4 Year wise count of countries having more the 75% electricity Access:


select * from oil_combo

select * from rural 

select Top 1 (select count(*) from rural where Y_1990> 75)as "1990" , (select count(*) from rural where Y_1991> 75) as "1991" ,( select count(*) from rural where Y_1992> 75) as "1992"
,( select count(*) from rural where Y_1993> 75) as "1993",( select count(*) from rural where Y_1994> 75) as "1994",( select count(*) from rural where Y_1995> 75) as "1995"
,( select count(*) from rural where Y_1996> 75) as "1996",( select count(*) from rural where Y_1997> 75) as "1997",( select count(*) from rural where Y_1998> 75) as "1998"
,( select count(*) from rural where Y_1999> 75) as "1999",( select count(*) from rural where Y_2000> 75) as "2000",( select count(*) from rural where Y_2001> 75) as "2001"
,( select count(*) from rural where Y_2002> 75) as "2002",( select count(*) from rural where Y_2003> 75) as "2003",( select count(*) from rural where Y_2004> 75) as "2004"
,( select count(*) from rural where Y_2005> 75) as "2005" ,(select count(*)  from rural where Y_2006> 75) as "2006", (select count(*) from rural where Y_2007> 75) as "2007"
, (select count(*)  from rural where Y_2008> 75) as "2008", (select count(*) from rural where Y_2009> 75) as "2009"
, (select count(*)  from rural where Y_2010> 75) as "2010", (select count(*) from rural where Y_2011> 75) as "2011"
, (select count(*)  from rural where Y_2012> 75) as "2012", (select count(*) from rural where Y_2013> 75) as "2013"
, (select count(*)  from rural where Y_2014> 75) as "2014", (select count(*) from rural where Y_2015> 75) as "2015"
, (select count(*)  from rural where Y_2016> 75) as "2016", (select count(*) from rural where Y_2017> 75) as "2017"
, (select count(*)  from rural where Y_2018> 75) as "2018", (select count(*) from rural where Y_2019> 75) as "2019"
, (select count(*)  from rural where Y_2020> 75) as "2020" from rural



---- q 5.1 Region Wise Production of electricity through Nuclear resources:
---Method-1
select s1.Region ,  n/d  as Nuclear_Production from (
	select  Region , sum(isnull(Y_1960,0) + isnull(Y_1961,0) + isnull(Y_1962,0) + isnull(Y_1963,0) + isnull(Y_1964,0)
	+ isnull(Y_1965,0) + isnull(Y_1966,0) + isnull(Y_1967,0) + isnull(Y_1968,0) + isnull(Y_1969,0)
	+ isnull(Y_1970,0) + isnull(Y_1971,0) + isnull(Y_1972,0) + isnull(Y_1973,0) + isnull(Y_1974,0)
	+ isnull(Y_1975,0) + isnull(Y_1976,0) + isnull(Y_1977,0) + isnull(Y_1978,0) + isnull(Y_1979,0)
	+ isnull(Y_1980,0) + isnull(Y_1981,0) + isnull(Y_1982,0) + isnull(Y_1983,0) + isnull(Y_1984,0)
	+ isnull(Y_1985,0) + isnull(Y_1986,0) + isnull(Y_1987,0) + isnull(Y_1988,0) + isnull(Y_1989,0) + isnull(Y_1990,0)
	+ isnull(Y_1991,0) + isnull(Y_1992,0) + isnull(Y_1993,0) + isnull(Y_1994,0) + isnull(Y_1995,0) 
	+ isnull(Y_1996,0) + isnull(Y_1997,0) + isnull(Y_1998,0) + isnull(Y_1999,0) + isnull(Y_2000,0)
	+ isnull(Y_2001,0) + isnull(Y_2002,0) + isnull(Y_2003,0) + isnull(Y_2004,0) + isnull(Y_2005,0)
	+ isnull(Y_2006,0) + isnull(Y_2007,0) + isnull(Y_2008,0) + isnull(Y_2009,0) + isnull(Y_2010,0)
	+ isnull(Y_2011,0) + isnull(Y_2012,0) + isnull(Y_2013,0) + isnull(Y_2014,0) + isnull(Y_2015,0)
	) as n ,
	(count( Y_1960 ) + count(Y_1961) + count(Y_1962) + count(Y_1963) + count(Y_1964) + count(Y_1965)+ count(Y_1966)
	+ count(Y_1967) + count(Y_1968) + count(Y_1969) + count(Y_1970) + count(Y_1971) + count(Y_1972)+ count(Y_1973)
	+ count(Y_1974) + count(Y_1975) + count(Y_1976) + count(Y_1977) + count(Y_1978) + count(Y_1979)+ count(Y_1980)
	+ count(Y_1981) + count(Y_1982) + count(Y_1983) + count(Y_1984) + count(Y_1985) + count(Y_1986)+ count(Y_1987)
	+ count(Y_1988) + count(Y_1989) + count(Y_1990) 
	+ count( Y_1991 ) + count(Y_1992) + count(Y_1993) + count(Y_1994) + count(Y_1995) + count(Y_1996)+ count(Y_1997) 
	+ count(Y_1998) + count(Y_1999) + count(Y_2000) + count(Y_2001) + count(Y_2002) + count(Y_2003)+ count(Y_2004) 
	+ count(Y_2005) + count(Y_2006) + count(Y_2007) + count(Y_2008) + count(Y_2009) + count(Y_2010)+ count(Y_2011) 
	+ count(Y_2012) + count(Y_2013) + count(Y_2014) + count(Y_2015))
	as d
	from nuclear_combo
	group by  Region
	) as s1
	where s1.d != 0 and s1.Region is not null order by Nuclear_Production desc


---Method-2

Select Region , Avg(Production) as Avg_Nuclear_Prod from (select Region  , [Year], Production 
from (Select Region , [Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from nuclear_combo )aa
unpivot 
(production for [Year] in ([Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where region is not null group by Region order by Avg_Nuclear_Prod desc







---- q 5.2 Income Wise Production of electricity through Nuclear resources:
---Method-1
select s1.IncomeGroup ,  n/d as Nuclear_Production  from (
	select  IncomeGroup , sum(isnull(Y_1960,0) + isnull(Y_1961,0) + isnull(Y_1962,0) + isnull(Y_1963,0) + isnull(Y_1964,0)
	+ isnull(Y_1965,0) + isnull(Y_1966,0) + isnull(Y_1967,0) + isnull(Y_1968,0) + isnull(Y_1969,0)
	+ isnull(Y_1970,0) + isnull(Y_1971,0) + isnull(Y_1972,0) + isnull(Y_1973,0) + isnull(Y_1974,0)
	+ isnull(Y_1975,0) + isnull(Y_1976,0) + isnull(Y_1977,0) + isnull(Y_1978,0) + isnull(Y_1979,0)
	+ isnull(Y_1980,0) + isnull(Y_1981,0) + isnull(Y_1982,0) + isnull(Y_1983,0) + isnull(Y_1984,0)
	+ isnull(Y_1985,0) + isnull(Y_1986,0) + isnull(Y_1987,0) + isnull(Y_1988,0) + isnull(Y_1989,0) + isnull(Y_1990,0)
	+ isnull(Y_1991,0) + isnull(Y_1992,0) + isnull(Y_1993,0) + isnull(Y_1994,0) + isnull(Y_1995,0) 
	+ isnull(Y_1996,0) + isnull(Y_1997,0) + isnull(Y_1998,0) + isnull(Y_1999,0) + isnull(Y_2000,0)
	+ isnull(Y_2001,0) + isnull(Y_2002,0) + isnull(Y_2003,0) + isnull(Y_2004,0) + isnull(Y_2005,0)
	+ isnull(Y_2006,0) + isnull(Y_2007,0) + isnull(Y_2008,0) + isnull(Y_2009,0) + isnull(Y_2010,0)
	+ isnull(Y_2011,0) + isnull(Y_2012,0) + isnull(Y_2013,0) + isnull(Y_2014,0) + isnull(Y_2015,0)
	) as n ,
	(count( Y_1960 ) + count(Y_1961) + count(Y_1962) + count(Y_1963) + count(Y_1964) + count(Y_1965)+ count(Y_1966)
	+ count(Y_1967) + count(Y_1968) + count(Y_1969) + count(Y_1970) + count(Y_1971) + count(Y_1972)+ count(Y_1973)
	+ count(Y_1974) + count(Y_1975) + count(Y_1976) + count(Y_1977) + count(Y_1978) + count(Y_1979)+ count(Y_1980)
	+ count(Y_1981) + count(Y_1982) + count(Y_1983) + count(Y_1984) + count(Y_1985) + count(Y_1986)+ count(Y_1987)
	+ count(Y_1988) + count(Y_1989) + count(Y_1990) 
	+ count( Y_1991 ) + count(Y_1992) + count(Y_1993) + count(Y_1994) + count(Y_1995) + count(Y_1996)+ count(Y_1997) 
	+ count(Y_1998) + count(Y_1999) + count(Y_2000) + count(Y_2001) + count(Y_2002) + count(Y_2003)+ count(Y_2004) 
	+ count(Y_2005) + count(Y_2006) + count(Y_2007) + count(Y_2008) + count(Y_2009) + count(Y_2010)+ count(Y_2011) 
	+ count(Y_2012) + count(Y_2013) + count(Y_2014) + count(Y_2015))
	as d
	from nuclear_combo
	group by  IncomeGroup
	) as s1
	where s1.d != 0 and s1.IncomeGroup is not null order by Nuclear_Production desc

---Method-2


Select IncomeGroup , Avg(Production) as Avg_Nuclear_Prod from (select IncomeGroup  , [Year], Production 
from (Select IncomeGroup , [Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from nuclear_combo )aa
unpivot 
(production for [Year] in ([Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where IncomeGroup is not null group by IncomeGroup order by Avg_Nuclear_Prod desc


 ---- q 5.2 Income Wise Production of electricity through Nuclear resources:


 Select IncomeGroup , Avg(Production) as Avg_Nuclear_Prod from (select IncomeGroup  , [Year], Production 
from (Select IncomeGroup , [Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from oil_combo )aa
unpivot 
(production for [Year] in ([Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where IncomeGroup is not null group by IncomeGroup order by Avg_Nuclear_Prod desc



 -----Yearwise comparision of electricity production through nuclear and oil 


Select A.Year , A.Avg_Nuclear_Prod , B.Avg_oil_Prod from 
(Select Year , Avg(Production) as Avg_Nuclear_Prod from (select Country_Name  , [Year], Production 
from (Select Country_Name , [Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from nuclear_combo )aa
unpivot 
(production for [Year] in ([Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
group by Year) as A 
inner join
(Select Year , Avg(Production) as Avg_oil_Prod from (select Country_Name  , [Year], Production 
from (Select Country_Name , [Y_1960],[Y_1961]15]
from oil_combo )aa
unpivot 
(production for [Year] in ([Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
group by Year) as B 
on A.Year = B.Year order by Year


----Q3- Country average access Vs World average access

Select * into xp from (Select Country_Name , Year , Avg(Production) as Avg_total_Prod from (select Country_Name  , [Year], Production 
from (Select Country_Name , [Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015],[Y_2016],[Y_2017],[Y_2018],[Y_2019],[Y_2020]
from total_combo )aa
unpivot 
(production for [Year] in ([Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015],[Y_2016],[Y_2017],[Y_2018],[Y_2019],[Y_2020]))as xp)A
group by Country_Name , Year)a

select * , avg(Avg_total_Prod) over (partition by Year) as world_Avg from xp


----Country wise Average transmission loss 
,[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_20
select * from losses_combo

Select Country_Name , Avg(Loss) as Avg_loss from (select Country_Name  , [Year], Loss 
from (Select Country_Name , [Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014]
from losses_combo where Region is not null )aa
unpivot 
(loss for [Year] in ([Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014]))as xp)A
group by Country_Name order by Avg_loss desc


-----Region Wise Average electricity production through Nuclear Vs Oil

Select A.Region , A.Avg_Nuclear_Prod, B.Avg_oil_Prod from 
(Select Region , Avg(Production) as Avg_Nuclear_Prod from (select Region , [Year], Production 
from (Select Region , [Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from nuclear_combo )aa
unpivot 
(production for [Year] in ([Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where region is not null group by Region) as A 
 inner join 

(Select Region , Avg(Production) as Avg_oil_Prod from (select Region  , [Year], Production 
from (Select Region , [Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from oil_combo )aa
unpivot 
(production for [Year] in ([Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where region is not null group by Region) as B 
on A.Region = B.Region





----Q7 Decade wise Comparison of production of electricity through oil:


Select A.*, B.oil_1981_1990, C.Oil_1991_2000, D.Oil_2001_2010 from

(Select Region , Avg(Production) as Oil_1971_1980 from (select Region  , [Year], Production 
from (Select Region , [Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
from oil_combo )aa
unpivot 
(production for [Year] in ([Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]))as xp)A
where region is not null group by Region ) as A
inner join 

(Select Region , Avg(Production) as Oil_1981_1990 from (select Region  , [Year], Production 
from (Select Region , [Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
from oil_combo )aa
unpivot 
(production for [Year] in ([Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]))as xp)A
 where region is not null group by Region) as B 
on A.Region = B.Region inner join

(Select Region , Avg(Production) as Oil_1991_2000 from (select Region  , [Year], Production 
from (Select Region , [Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
from oil_combo )aa
unpivot 
(production for [Year] in ([Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]))as xp)A
 where region is not null group by Region ) as C
on B.Region = C.Region inner join

(Select Region , Avg(Production) as Oil_2001_2010 from (select Region  , [Year], Production 
from (Select Region , [Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
from oil_combo )aa
unpivot 
(production for [Year] in ([Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]))as xp)A
 where region is not null group by Region ) as D
on C.Region = D.Region


----- Region wise average prodution of electricity through renewable sources:

Select Region , Avg(Production) as Avg_renewable_Prod from (select Region  , [Year], Production 
from (Select Region, [Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from renewable_combo )aa
unpivot 
(production for [Year] in ([Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)AA where Region is not null 
group by Region 



-----Region Wise Average electricity production through Nuclear Vs Oil 

Select Region , Avg(Production) as Avg_Oil_Prod from (select Region  , [Year], Production 
from (Select Region , [Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from oil_combo )aa
unpivot 
(production for [Year] in ([Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where region is not null group by Region order by Avg_Oil_Prod desc



 
-----Income Wise Average electricity production through Oil 

 Select IncomeGroup , Avg(Production) as Avg_Oil_Prod from (select IncomeGroup  , [Year], Production 
from (Select IncomeGroup , [Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from oil_combo )aa
unpivot 
(production for [Year] in ([Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where IncomeGroup is not null group by IncomeGroup order by Avg_Oil_Prod desc


 -----Income Wise Average electricity production through Nuclear

Select IncomeGroup , Avg(Production) as Avg_nuclear_Prod from (select IncomeGroup  , [Year], Production 
from (Select IncomeGroup , [Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]
from nuclear_combo )aa
unpivot 
(production for [Year] in ([Y_1960],[Y_1961],[Y_1962],[Y_1963],[Y_1964],[Y_1965],[Y_1966],[Y_1967],[Y_1968],[Y_1969],[Y_1970]
,[Y_1971],[Y_1972],[Y_1973],[Y_1974],[Y_1975],[Y_1976],[Y_1977],[Y_1978],[Y_1979],[Y_1980]
,[Y_1981],[Y_1982],[Y_1983],[Y_1984],[Y_1985],[Y_1986],[Y_1987],[Y_1988],[Y_1989],[Y_1990]
,[Y_1991],[Y_1992],[Y_1993],[Y_1994],[Y_1995],[Y_1996],[Y_1997],[Y_1998],[Y_1999],[Y_2000]
,[Y_2001],[Y_2002],[Y_2003],[Y_2004],[Y_2005],[Y_2006],[Y_2007],[Y_2008],[Y_2009],[Y_2010]
,[Y_2011],[Y_2012],[Y_2013],[Y_2014],[Y_2015]))as xp)A
 where IncomeGroup is not null group by IncomeGroup order by Avg_nuclear_Prod desc


----------





