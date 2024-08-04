print('>>Script: First Login Event [loading --> OK]')  -- 名称,不能与其他混淆

-- 加入工会
local function JoinGuild(event, player)
	local guildid = { --自动加入的工会名称
		[0] = '远征', --联盟
		[1] = '远征'  --部落
	}
	local guildrank={ --默认加入的等级
		--等级可以在guild_rank表查看字段rid，一般默认为会长、官员、精英、会员、新人，依次为0，1，2，3，4
		[0] = 4, --联盟 
		[1] = 4  --部落
	}
	local teamIndex = player:GetTeam();
	local guild = GetGuildByName(guildid[teamIndex]);
	
    if guild ~= nil then
    	--AddMember(玩家,等级) 向工会添加成员
        guild:AddMember(player, guildrank[teamIndex]);
        --在客户端打印一行提示，这个比较常用，可以用来输出很多东西
        player:SendBroadcastMessage('你已加入工会['..guildid[teamIndex]   ..']');
    end
end

-- 赠送礼物
local function GiveGifts(event, player)   -- 玩家首次登录
        -- player:AddItem(23162, 11)             -- 弗洛尔的无尽抗性宝箱 * 个数。你可以根据物品id自行设置
        player:AddItem(1725, 11)                 -- 1725(12格), 3914(14格)
        player:ModifyMoney(10000)                -- 1个金币
                                                 -- 公告等等放在后面,否则可能失效,具体原因不知道
        -- SendWorldMessage("|cffff00ff[温馨提醒]|r".."["..player:GetName().."]|cFF0099FF欢迎来到335天蓝单机魔兽(Amberina整合版)！|r")
end

-- 武器技能
local function LearnSpells(event, player)
	local CLASS_WARRIOR 		= 1		--战士
	local CLASS_PALADIN			= 2		--圣骑士
	local CLASS_HUNTER			= 3		--猎人
	local CLASS_ROGUE			= 4		--盗贼
	local CLASS_PRIEST			= 5		--牧师
	local CLASS_DEATH_KNIGHT	= 6		--死亡骑士
	local CLASS_SHAMAN			= 7		--萨满
	local CLASS_MAGE			= 8		--法师
	local CLASS_WARLOCK			= 9		--术士
	local CLASS_DRUID			= 11	--德鲁伊
	
	local SKILL = {
		[CLASS_WARRIOR] = {202,199,197,227,200,201,198,196,266,15590,1180,5011,264,2567, 34090,58983},
		[CLASS_PALADIN] = {202,199,197,200,201,198,196,                                  34090,58983},
		[CLASS_HUNTER] = {202,197,227,200,201,196,266,15590,1180,5011,264,               34090,58983},
		[CLASS_ROGUE] = {201,198,196,266,15590,1180,5011,264,2567,                       34090,58983},
		[CLASS_PRIEST] = {227,198,1180,                                                  34090,58983},
		[CLASS_DEATH_KNIGHT] = {202,199,197,200,201,198,196,                             34090,58983},
		[CLASS_SHAMAN] = {199,197,227,198,196,15590,1180,                                34090,58983},
		[CLASS_MAGE] = {227,201,1180,                                                    34090,58983},
		[CLASS_WARLOCK] = {227,201,1180,                                                 34090,58983},
		[CLASS_DRUID] = {199,227,200,198,15590,1180,                                     34090,58983},
	};
	
	local ClassIndex  = player:GetClass()   --得到职业号
	local ClassSkills = SKILL[ClassIndex]   --该职业的该等级技能表
	for k, v in pairs(ClassSkills) do	    --k=1，开始把每个技能读出来赋值为v
		if not player:HasSpell(v) then
			player:LearnSpell(v)	        --学习每个技能
		end
	end
	
end

local function HandleEvent(event, player)
	GiveGifts(event, player);
	LearnSpells(event, player);
	JoinGuild(event, player);
end

RegisterPlayerEvent(30, HandleEvent) --首次登录