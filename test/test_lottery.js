const Lottery = artifacts.require("Lottery");

contract('Lottery', async accounts => {

    it('should start with balance equal 0', async () => {
        const instance = await Lottery.deployed();
        const balance = await web3.eth.getBalance(instance.address);
        assert.equal(balance, 0);
    })

    it('should be able to depois money', async () => {
        const instance = await Lottery.deployed();
        await web3.eth.sendTransaction({ from: accounts[1], to: instance.address, value: 1 })
        const balance = await web3.eth.getBalance(instance.address);
        assert.equal(balance, 1)
    })
})