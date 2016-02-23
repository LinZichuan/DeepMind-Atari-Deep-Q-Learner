
local cnnGameEnv = torch.class('cnnGameEnv')

function cnnGameEnv:__init(opt)
	print('init gameenv')
end

function cnnGameEnv:reward(minibatch_index)
	--compute minibatch loss and compute reward	
end

function cnnGameEnv:getActions()
	local gameActions = {}
	for i=0,2048 do
		gameActions[i+1] = i
	end
	return gameActions
end

function cnnGameEnv:nObsFeature()

end

function cnnGameEnv:getState()

end

function cnnGameEnv:step(action, tof)
	print('step')
end

function cnnGameEnv:nextRandomGame()

end

function cnnGameEnv:newGame()

end

