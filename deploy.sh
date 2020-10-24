docker build -t jgutierrez91/multi-client:lastest -t jgutierrez91/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jgutierrez91/multi-server:lastest -t jgutierrez91/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jgutierrez91/multi-worker:lastest -t jgutierrez91/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jgutierrez91/multi-client:lastest
docker push jgutierrez91/multi-server:lastest
docker push jgutierrez91/multi-worker:lastest

docker push jgutierrez91/multi-client:$SHA
docker push jgutierrez91/multi-server:$SHA
docker push jgutierrez91/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jgutierrez91/multi-server:$SHA

kubectl set image deployments/client-deployment client=jgutierrez91/multi-client:$SHA

kubectl set image deployments/worker-deployment worker=jgutierrez91/multi-worker:$SHA