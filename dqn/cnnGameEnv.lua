
local cnnGameEnv = torch.class('cnnGameEnv')

function cnnGameEnv:__init(opt)
	print('init gameenv')
end

function cnnGameEnv:loaddata()
	--epoch_batch_indices_1.dat  epoch_classes_1.dat  epoch_loss_1.dat  epoch_state_0.dat
	--/home/jie/lzc/my-DeepMind-Atari-Deep-Q-Learner/save
	local states = torch.load('/home/jie/lzc/my-DeepMind-Atari-Deep-Q-Learner/save/epoch_state_0.dat') 
	local classes = torch.load('/home/jie/lzc/my-DeepMind-Atari-Deep-Q-Learner/save/epoch_classes_1.dat') 
	local losslist = torch.load('/home/jie/lzc/my-DeepMind-Atari-Deep-Q-Learner/save/epoch_loss_1.dat') 
	local size = classes:storage():size()
	print(size)
	local batch_size = 64
	local batch_num = size/batch_size
	print(batch_num)
	local actions = torch.Tensor(batch_num, 10)
	for i=1,batch_num do
		local a = batch_size*(i-1)+1
		local b = batch_size*i
		local map = torch.zeros(10)
		for j=a,b do
			map[math.floor(classes[j])] = map[math.floor(classes[j])] + 1
		end
		for j=1,10 do
			if (map[j] > 0) then
				actions[i][j] = 1
			else
				actions[i][j] = 0
			end
		end
		print(actions[i])
	end
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

