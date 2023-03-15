FROM runpod/stable-diffusion:web-automatic-1.5.16 as stage0

SHELL ["/bin/bash", "-c"]

ENV PATH="${PATH}:/workspace/stable-diffusion-webui/venv/bin"

WORKDIR /

RUN rm /workspace/v1-5-pruned-emaonly.ckpt
RUN cd /workspace/stable-diffusion-webui && git pull
##RUN wget -O model.safetensors "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors"
RUN pip install -U xformers
RUN pip install runpod

from stage0 as stage1
ADD handler.py .
ADD start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT [ "/bin/bash", "/start.sh" ]
