cat << "EOF"
+ - - - - - - - - - - - - - - - - - - - - - - - - +
Once it is up, visit the following 
url: http://localhost:8888/lab to get started

+ - - - - - - - - - - - - - - - - - - - - - - - - +
EOF

jupyter lab --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}
