-- autorun.lua : chargé au démarrage par la ligne "plugin=autorun" de config\config.ini.
-- Charge chaque script de la liste ci-dessous avec pcall : si l'un d'eux a une erreur,
-- NGPad démarre quand même et l'erreur s'affiche dans la console Lua (F12).

local scripts = {
	'bonjour',
	'scoreup',   -- ScoreUp\init.lua
}

for _, name in ipairs(scripts) do
	local ok, err = pcall(require, name)
	if not ok then
		print('Erreur au chargement de ' .. name .. ' : ' .. tostring(err))
	end
end
