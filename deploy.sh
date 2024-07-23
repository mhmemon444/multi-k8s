docker build -t mhmemon123/multi-client:latest -t mhmemon123/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mhmemon123/multi-server:latest -t mhmemon123/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mhmemon123/multi-worker:latest  -t mhmemon123/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mhmemon123/multi-client:latest
docker push mhmemon123/multi-server:latest
docker push mhmemon123/multi-worker:latest
docker push mhmemon123/multi-client:$SHA
docker push mhmemon123/multi-server:$SHA
docker push mhmemon123/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mhmemon123/multi-server:$SHA
kubectl set image deployments/client-deployment client=mhmemon123/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mhmemon123/multi-worker:$SHA