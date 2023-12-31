
The Smart City sample can be deployed with Kubernetes. 

### Kubernetes Setup

- Follow the [instructions](setup-kubernetes.md) to setup your Kubernetes cluster. 

- Optional: setup password-less access from the Kubernetes controller to each worker node (required by ```make update```):   

```
ssh-keygen
ssh-copy-id <worker-node>
```

- Start/stop services as follows:   

```
mkdir build
cd build
cmake ..
make
make update # optional for private docker registry
make start_kubernetes
make stop_kubernetes
```

---

The command ```make update``` uploads the sample images to each worker node. If you prefer to use a private docker registry, configure the sample, `cmake -DREGISTRY=<registry-url> ..`, to push images to the private registry after each build.  

---

### Multiple Office Start/Stop

The sample supposes dynamic office starting/stopping. You can selectively start and stop any office, as follows:

```
cmake -DNOFFICES=2 ..
make

SCOPE=cloud make start_kubernetes
SCOPE=office1 make start_kubernetes
SCOPE=office2 make start_kubernetes
...
SCOPE=office1 make stop_kubernetes
...
SCOPE=office1 make start_kubernetes
...
make stop_kubernetes  # cleanup all
```

### Database High Availability 

Specify the following optional parameters for cloud or office database high-availability settings:   

```
HA_CLOUD=3 make start_kubernetes
...
HA_CLOUD=3 make stop_kubernetes

HA_CLOUD=3 HA_OFFICE=3 make start_kubernetes
...
HA_CLOUD=3 HA_OFFICE=3 make stop_kubernetes
```

---

Each database instance requires about 2GB memory.

---

### See Also 

- [Helm Charts](helm/smtc/README.md)  
- [Utility Scripts](../../doc/script.md)   
- [CMake Options](../../doc/cmake.md)  

