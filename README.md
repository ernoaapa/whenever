# Whenever
Docker image which executes the command, when ever files the directory changes.

Inspired by [https://gist.github.com/mpapi/4656389]()

## Usage
You can use this in Kubernetes to execute some shell command when _ConfigMap_ changes.

```yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: whenever
spec:
  containers:
  - image: ernoaapa/whenever:latest
    name: whenever
    args:
      # Watch this directory recursively
      - /config
      # Execute this command
      - cat /config/msg.txt
    volumeMounts:
    - name: config
      mountPath: /config
  volumes:
    - name: config
      configMap:
        name: my-config

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
data:
  msg.txt: Hello world!
```

## Example
```shell
kubectl apply -f example.yml
# Wait the pod is created...

# Check the output in one window
kubectl logs whenever -f

# In another window, edit the config
kubectl edit configmap my-config

# You should see the changes after while (max 30s)
```
