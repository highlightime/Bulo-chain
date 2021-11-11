## .env
<p>
  
> .env for mainnet  
> .env.ropsten for ropsten  
> .env.rikeby for rinkeby

</p>

```
DEPLOYER_ACCOUNT=deployer account address
DEPLOYER_PRIVATE_KEY=private key of deploy account
PROVIDER_API_KEY=infura project id
CHAIN_ID=ethereum network chain id
NETWORK=ethereum network name
```

> network should be lower case  
> ex) `ropsten`, `rinkeby`, `mainnet`

## Compile
``` bash
npm run compile
```

## Deploy(testnet)
``` bash
docker-compose up --build ropsten(ropsten)
docker-compose up --build rinkeby(rinkeby)
```

## Deploy(Mainnet)
```
docker-compose up --build mainnet
```
