USER_DIR="/home/user"
CONDA_DIR="$USER_DIR/miniconda3"
MASTER_IP="192.168.0.2"

apt-get install -y htop

if [ ! -d $CONDA_DIR ] 
then
   echo "Conda does not exist. Creating..." 
   wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh;
   bash Miniconda3-latest-Linux-x86_64.sh -b
   $CONDA_DIR/bin/conda create -y -n dask python=3.9
   $CONDA_DIR/bin/conda install -n dask -y -c conda-forge dask distributed scikit-learn scipy numpy pandas geopandas dask-geopandas
else
   echo "Conda exists"
fi

MY_IP=$(/sbin/ifconfig eth2 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')

if [ $MY_IP == $MASTER_IP ]
then
    echo "Initing Scheduler"
    $CONDA_DIR/envs/dask/bin/dask-scheduler
else
    echo "Initing Worker"
    $CONDA_DIR/envs/dask/bin/dask-worker tcp://$MASTER_IP:8786
fi