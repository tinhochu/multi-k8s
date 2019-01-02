docker build -t tinhochu/multi-client:latest -t tinhochu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tinhochu/multi-server:latest -t tinhochu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tinhochu/multi-worker:latest -t tinhochu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tinhochu/multi-client:latest
docker push tinhochu/multi-server:latest
docker push tinhochu/multi-worker:latest

docker push tinhochu/multi-client:$SHA
docker push tinhochu/multi-server:$SHA
docker push tinhochu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tinhochu/multi-server:$SHA
kubectl set image deployments/client-deployment client=tinhochu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tinhochu/multi-worker:$SHA