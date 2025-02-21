drop user prakbd cascade;
create user prakbd identified by prakbd;
conn prakbd/prakbd

set linesize 1000;
set pagesize 500;

spool "D:\SPOOL_220116919_3.sql";
set time on;
set sqlprompt "220116919 >";

--QUERY
--NO 1
select
    rpad(initcap(g.name) ||
    ' dengan stok = ' ||
    g.stock, 64, ' ') as GAME
from
    game g
where
    g.stock > (select avg(g.stock) from game g)
order by
    length(initcap(g.name) || ' dengan stok = ' || g.stock) desc, g.stock desc;

select
    rpad(initcap(name) ||
    ' dengan stok = ' ||
    stock,64) as "GAME"
from
    game
where
    stock > (select avg(stock) from game)
order by
    length(initcap(name) || ' dengan stok = ' || stock ) desc,
    stock desc;

--NO 2
select
    rpad(g.name || ' by ' || d.name,76) as "GAME YG MEMILIKI 2 PLATFORM"
from
    game g, game_platform gp, platform p, developer d
where
    gp.game_id = g.game_id AND
    p.platform_id = gp.platform_id AND
    d.developer_id = g.developer_id
group by
    g.name, d.name
having
    count(p.platform_id) = 2
order by 1;

--NO 3
select
    s.supplier_id as "SUPID",
    rpad(s.name,40) as "SUPPLIER",
    (
        select sum(total)
        from orders o
        where o.supplier_id = s.supplier_id
    ) as "TOTAL"
from
    supplier s
order by "TOTAL" desc;

spool off;