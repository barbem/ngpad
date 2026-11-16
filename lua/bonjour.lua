-- bonjour.lua : petit exemple de script NGPad.
-- Ctrl+Maj+B annonce la ligne courante au lecteur d'écran.

print('bonjour.lua chargé')   -- visible dans la console Lua (F12)

local function attach(doc)
	doc:bindAccelerator('Ctrl+Shift+B', function()
		app.sayText('Bonjour ! Ligne courante : ' .. doc.editor:getLine(0))
	end)
end

-- Documents déjà ouverts (aucun au démarrage, mais utile si on recharge le script)
for _, doc in pairs(app.documents) do attach(doc) end

-- Chaque document créé ou ouvert ensuite.
-- Ne rien retourner = l'événement continue vers les autres scripts.
app:bind(Event.DOC_CREATED, function(e)
	attach(e.document)
end)
