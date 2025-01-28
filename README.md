Projeto de Detecção de Objetos com rede Yolo

Esse é meu projeto para treinar a rede YOLO usando o **COCO Dataset**. Vou explicar o que fiz e como você pode usar esse projeto.


Como usei o Dataset COCO:

Baixei os arquivos  
   Para treinar a YOLO, fiz o download do COCO pelo site deles. Peguei:
   - Imagens para treinar (train2017.zip) e validar (val2017.zip).
   - As anotações (annotations_trainval2017.zip) que dizem onde estão os objetos nas imagens.

Escolhi algumas classes para focar
   Usei "dog" (cachorro) e "cat" (gato). O COCO tem 80 classes no total, mas escolhi só essas para simplificar.

Convertei as marcações para o formato do YOLO 
   As anotações do COCO estão no formato JSON. Usei um script Python para transformar essas informações no formato que o YOLO entende (que são coordenadas de caixas de delimitação normalizadas).


Como rodar o projeto:

Se quiser usar o que fiz, siga os passos:

Baixe o Dataset COCO
   Vá no site [COCO Download](https://cocodataset.org/#download) e baixe:
   - Imagens: `train2017.zip` e `val2017.zip`.
   - Anotações: `annotations_trainval2017.zip`.

