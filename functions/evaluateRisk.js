const [uuid] = args;
const {RISK_API_URL} = process.env;
const response = Functions.makeHttpRequest({url: RISK_API_URL});
const riskRating = +response.data;
if (typeof riskRating !== 'number') {
    throw new Error('Failed to get riskRating for uuid: ' + uuid);
}
return Functions.encodeUint256(riskRating);