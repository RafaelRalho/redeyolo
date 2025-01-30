# Clonar o repositório do Darknet
git clone https://github.com/AlexeyAB/darknet.git
cd darknet

# Alterar a configuração para CPU (desabilitar CUDA)
sed -i 's/GPU=1/GPU=0/' Makefile
sed -i 's/CUDNN=1/CUDNN=0/' Makefile
sed -i 's/OPENCV=0/OPENCV=1/' Makefile  # Habilitar OpenCV para visualização de imagens

# Compilar o Darknet
make

# Baixar os pesos pré-treinados do YOLOv3
wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v4_pre/yolov3.weights

# Criar diretório para o COCO Dataset e entrar nele
mkdir -p coco
cd coco

# Baixar imagens do COCO Dataset (treinamento e validação) e anotações
wget http://images.cocodataset.org/zips/train2017.zip
wget http://images.cocodataset.org/zips/val2017.zip
wget http://images.cocodataset.org/annotations/annotations_trainval2017.zip

# Extrair os arquivos baixados
unzip train2017.zip
unzip val2017.zip
unzip annotations_trainval2017.zip

# Retornar ao diretório principal do Darknet
cd ..

# Editar o arquivo de configuração para usar o COCO Dataset
# Usando yolov3.cfg como exemplo
cp cfg/yolov3.cfg cfg/yolov3_custom.cfg

# Alterar os parâmetros do arquivo de configuração para retreinamento
sed -i 's/batch=1/batch=64/' cfg/yolov3_custom.cfg
sed -i 's/subdivisions=1/subdivisions=16/' cfg/yolov3_custom.cfg
sed -i 's/max_batches=500200/max_batches=4000/' cfg/yolov3_custom.cfg
sed -i 's/steps=400000,450000/steps=3200,3600/' cfg/yolov3_custom.cfg

# Adicionar a configuração das classes
NUM_CLASSES=2
sed -i "s/classes=80/classes=$NUM_CLASSES/" cfg/yolov3_custom.cfg

# Configurar os arquivos de rótulos e dados
echo "train = data/train.txt
valid = data/val.txt
names = data/obj.names
backup = backup/" > data/obj.data

echo "classe1
classe2" > data/obj.names

# Executar o treinamento com o COCO Dataset
./darknet detector train data/obj.data cfg/yolov3_custom.cfg yolov3.weights -dont_show