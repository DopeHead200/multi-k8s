docker build -t dopehead100/multi-client:latest -t dopehead100/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dopehead100/multi-server:latest -t dopehead100/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dopehead100/multi-worker:latest -t dopehead100/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dopehead100/multi-client:latest
docker push dopehead100/multi-server:latest
docker push dopehead100/multi-worker:latest
docker push dopehead100/multi-client:$SHA
docker push dopehead100/multi-server:$SHA
docker push dopehead100/multi-worker:$SHA

kubectl apply -f k8s
kubectt set image deployments/server-deployment server=dopehead100/multi-server:$SHA
kubectl set image deployments/client-deployment client=dopehead100/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dopehead100/multi-worker:$SHA
