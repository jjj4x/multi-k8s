
echo BUILD
docker build -t jjjax/multi-client:latest -t "jjjax/multi-client:${SHA}" -f ./client/Dockerfile ./client
docker build -t jjjax/multi-server:latest -t "jjjax/multi-server:${SHA}" -f ./server/Dockerfile ./server
docker build -t jjjax/multi-worker:latest -t "jjjax/multi-worker:${SHA}" -f ./worker/Dockerfile ./worker

echo PUSH
docker push jjjax/multi-client:latest
docker push "jjjax/multi-client:${SHA}"
docker push jjjax/multi-server:latest
docker push "jjjax/multi-server:${SHA}"
docker push jjjax/multi-worker:latest
docker push "jjjax/multi-worker:${SHA}"


kubectl apply -f k8s
kubectl set image deployments/server-deployment "server=jjjax/multi-server:${SHA}"
kubectl set image deployments/client-deployment "client=jjjax/multi-client:${SHA}"
kubectl set image deployments/worker-deployment "worker=jjjax/multi-worker:${SHA}"
