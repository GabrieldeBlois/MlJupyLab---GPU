# created for flexper by gabriel@flexper.fr
FROM gabrieldeblois/mljupylab:base

RUN pip install --upgrade pip

# running root commands
USER root
RUN apt-get update && apt-get upgrade -y

# passing to jovyan user
USER jovyan

# installing jupyter lab
    # A JupyterLab extension for Jupyter/IPython widgets.
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    # To browse in dataframes with filters
    jupyter labextension install qgrid2 --no-build && \
    # A theme
    jupyter labextension install @mohirio/jupyterlab-horizon-theme --no-build && \
    # A theme
    jupyter labextension install @oriolmirosa/jupyterlab_materialdarker && \
    # to browse inside the csv files - NOT SUPPORTED
    # jupyter labextension install jupyterlab_voyager --no-build && \
    # to code format easily and respect a norm (pep8)
    jupyter labextension install @ryantam626/jupyterlab_code_formatter --no-build && \
    # to have a diff on version control directly on the notebook
    jupyter labextension install nbdime-jupyterlab --no-build && \
    # a git tool - NOT SUPPORTED by current version
    # jupyter labextension install jupyterlab_bokeh --no-build && \
    # a better and faster plotting library - TO TEST
    jupyter labextension install bqplot --no-build && \
    # a git tool
    jupyter labextension install @jupyterlab/git --no-build && \
    # to browse plugins
    jupyter labextension install @jupyterlab/hub-extension --no-build && \
    # tensorflow's tensorbard integration
    # jupyter labextension install jupyterlab_tensorboard --no-build && \
    # debugging tool - to TEST
    # jupyter labextension install jupyterlab-kernelspy --no-build && \
    # this is to try absolutely: link: https://github.com/plotly/jupyterlab-chart-editor
    jupyter labextension install jupyterlab-chart-editor --no-build && \
    jupyter labextension install plotlywidget --no-build && \
    # jupyter labextension install @jupyterlab/latex --no-build && \
    # jupyter labextension install jupyterlab-drawio --no-build && \
    # An extension to deal with maps data
    jupyter labextension install jupyter-leaflet --no-build && \
    jupyter lab build && \
    jupyter lab clean && \
    jlpm cache clean && \
    npm cache clean --force && \
    rm -rf $HOME/.node-gyp && \
    rm -rf $HOME/.local && \
    fix-permissions $CONDA_DIR $HOME
# copying useful files
COPY ./requirements.txt .
COPY ./launchJupyter.sh /
COPY ./.jupyter /home/jovyan/.jupyter

RUN pip install -r ./requirements.txt
RUN pip install --upgrade jupyterlab-git
# requirements.txt have no use anymore
RUN rm -f ./requirements.txt

RUN jupyter serverextension enable --py jupyterlab_code_formatter

ENV NB_PREFIX /

CMD ["sh","-c", "/launchJupyter.sh"]
