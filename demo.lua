require 'dp'

local cfd = torch.class('Cnnfordqn')

function cfd:__init()
	local input_preprocess = {}
    table.insert(input_preprocess, dp.Standardize())
	local ds = dp.Mnist{input_preprocess = input_preprocess}
	--print(ds)
	self.trainset = ds._train_set
end

function cfd:setbatch(indices)
	self.batch = self.trainset:index(nil, torch.LongTensor({1,2,3}))
	print(self.batch:nSample())
	--local dv = sb._inputs
	--v = dv:forwardGet('bchw', 'torch.LongTensor')
end

