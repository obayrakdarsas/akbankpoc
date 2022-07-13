# Start from a core stack version
FROM jupyter/all-spark-notebook:python-3.9.10

# graphviz is needed by dlpy
USER root
RUN apt-get update && apt-get install -y graphviz-dev graphviz htop patch

# Install additional packages to the default python3 environment
USER jovyan
RUN pip install 'swat' 'sas-dlpy' 'xgboost' 'sasctl' \
   'sas-esppy' 'sasoptpy' 'pipefitter' 'openpyxl' 'numpy' \
   'pandas' 'scipy' 'joblib' 'patsy' 'python-dateutil' 'pytz' \
   'scikit-learn' 'six' 'statsmodels' 'readline' 'geopandas' \
   'sas_kernel' 'tensorflow' 'keras'

USER root
# see https://github.com/nteract/hydrogen/issues/922
RUN echo "c.NotebookApp.disable_check_xsrf = True" >> /etc/jupyter/jupyter_notebook_config.py

# enable the git extension
RUN pip install --upgrade --pre jupyterlab-git
RUN nbdime extensions --enable

# switch back to non-super user
USER jovyan
