echo "DEPLOYMENT_FILE=${DEPLOYMENT_FILE}"
echo "POD_NAME=${POD_NAME}"
echo "CLUSTER_NAMESPACE=${CLUSTER_NAMESPACE}"


echo "Configuring cluster namespace"
if kubectl get namespace ${CLUSTER_NAMESPACE}; then
  echo -e "Namespace ${CLUSTER_NAMESPACE} found."
else
  kubectl create namespace ${CLUSTER_NAMESPACE}
  echo -e "Namespace ${CLUSTER_NAMESPACE} created."
fi


echo "DEPLOYING using manifest"
set -x

kubectl delete -n ${CLUSTER_NAMESPACE} pod ${POD_NAME}
kubectl apply -n ${CLUSTER_NAMESPACE} -f ${DEPLOYMENT_FILE}
set +x

