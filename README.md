# MlJupyLab---GPU
Jupyterlab docker image with CUDA support

## Docs

Official documentation [here](https://jupyterlab.readthedocs.io/en/stable/)

## Install and launch

### Install

You can clone this repository inside you working project directory. Then you will be able to mount your root working dir as a volume inside the home (`/home/jovyan`) directory in the container.

Here is a working exemple inside a docker-compose:
```yaml
    jupyterlab:
        build:
            context: ./mljupylab
        volumes: 
            - ./src:/home/jovyan/work
        ports: 
            - 8888:8888
```

### Launch jupyterlab

Once the docker container is launched, either by a docker-compose or a docker command similar to the following one: 
```sh
jupyter lab --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}
```
You will be able to connect to jupyterlab by browsing to the following url:
```
http://localhost:8888/lab
```
Or by clicking [here](http://localhost:8888/lab)

## On save script and html generation

Jupyter's .ipynb files may be quite uneasy to version control. That's the reason why you can add an empty file `.ipynb_saveprocress` in the same directory than the ipynb file you are working with. If you do so, it will generate 2 files:
- A HTML file you can easily share with anyone to show your super work
- A python script file to see what are the changes made in each commits wihtout struggling with all the raw binary data.
