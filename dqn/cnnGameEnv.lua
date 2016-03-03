
local cnnGameEnv = torch.class('cnnGameEnv')

function cnnGameEnv:__init(opt)
	self.state = torch.Tensor() --TODO
	--add a rouletee
	self.rouletee = {nil,nil,nil,nil}
	self.batchsize = 32
	self.nSample = 64
	print('init gameenv')
	print('loading data...')
	self.c = torch.Tensor(10)
	for i=1,10 do
		c[i] = torch.load('/home/jie/class2index/c'..i..'.dat')
	end
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
	for i=0,10 do
		gameActions[i+1] = i
	end
	return gameActions
end

function cnnGameEnv:nObsFeature()

end

function cnnGameEnv:getState() --state is set in cnn.lua
	--return state, reward, term
	return self.state, 0, false
end

function cnnGameEnv:step(action, tof)
	print('step')
	--subtitue rouletee[4], add action
	self.rouletee[4] = self.rouletee[3]
	self.rouletee[3] = self.rouletee[2]
	self.rouletee[2] = self.rouletee[1]
	self.rouletee[1] = action
	--select mini-batch according to actions
	--actions number are classes number
	local num = 0
	for i=1,4 do
		if (rouletee[i]) then
			num = num + 1
		end
	end
	local esize = self.batchsize / num
	--get datapoints from /home/jie/class2index/c?.dat according to each_size
	local res = {}
	--sample self.batchsize-esize*(num-1) from class r[1]
	local c1 = rouletee[1]
	local r1size = self.batchsize-esize*(num-1)
	local shuffle = torch.randperm(r1size)
	for j=1,r1size do
		res[#res+1] = self.c[c1][shuffle[j]]
	end
	--sample esize from class r[i]
	for i=2,4 do
		if (rouletee[i]) then
			local c = rouletee[i]
			local size = #self.c[c]:storage():size()
			local shuffle = torch.randperm(size)
			for j=1,size do
				res[#res+1] = self.c[c][shuffle[j]]
			end
		end
	end
	local batch = torch.Tensor(res) --batch_indices to learn
	--send batch to CNN to train, and receive loss, then compute reward!
	--write CNN train interface
end

function cnnGameEnv:nextRandomGame()

end

function cnnGameEnv:newGame()

end

