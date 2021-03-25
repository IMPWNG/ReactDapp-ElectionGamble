const ElectionGamble = artifacts.require('ElectionGamble.sol');

const SIDE = {
    MACRON: 0,
    LEPEN: 1
};

contract('ElectionGamble', addresses => {
    const [admin, oracle, gambler1, gambler2, gambler3, gambler4, _] = addresses;

    it('should work', async () => {
        const electionGamble = await ElectionGamble.new(oracle);

        await electionGamble.placeBet(
            SIDE.MACRON,
            {from: gambler1, value: web3.utils.toWei('1')}
        );
        await electionGamble.placeBet(
            SIDE.MACRON,
            { from: gambler2, value: web3.utils.toWei('1') }
        );
        await electionGamble.placeBet(
            SIDE.MACRON,
            { from: gambler3, value: web3.utils.toWei('2') }
        );
        await electionGamble.placeBet(
            SIDE.LEPEN,
            { from: gambler4, value: web3.utils.toWei('4') }
        );
    });

});