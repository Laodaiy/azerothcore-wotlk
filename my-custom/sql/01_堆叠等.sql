/*
select t.entry,t.class,t.subclass,ifnull(l.name, t.name) name,t.displayid,t.Quality,t.maxcount,t.stackable
from `item_template` t
left join `item_template_locale` l on l.id = t.entry and l.locale = 'zhCN'
where stackable > 1 and stackable < 9999
--          0-消耗品 3-珠宝 6-弹药 7-商业物品(材料)
and t.class in (0, 3, 6, 7);

-- 钓鱼
update fishing_loot_template SET maxcount = maxcount*2 ;

-- 矿石和草药
select t.item, l.name, t.Chance, t.LootMode, t.GroupId, t.MinCount, t.MaxCount
from gameobject_loot_template t
left join item_template_locale l on l.id = t.item and l.locale = 'zhCN'
left join item_template i on i.entry = t.item
where i.class = 7 and subclass in (7, 9);

--背包
select * from item_template where  ContainerSlots = 24 and class = 1 and subclass = 0;
*/

update `item_template` set stackable = stackable * 10, maxcount = maxcount * 10
where stackable > 1 and stackable < 9999 and class in (0, 3, 6, 7); 

-- 灵魂碎片
update `item_template` set maxcount = maxcount * 10, stackable = 320
where entry in (6265);
-- 灵魂石
update `item_template` set maxcount = maxcount * 10, stackable = stackable * 10
where entry in (5232, 16892, 16893, 16895, 16896, 22116, 36895);
