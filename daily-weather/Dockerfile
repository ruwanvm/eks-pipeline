FROM python:3.8-alpine3.14
MAINTAINER Ruwan Vimukthi Mettananda "ruwanvm@gmail.com"
# Set timezone
RUN apk update
RUN apk add --no-cache tzdata
ENV TZ="Asia/Colombo"
# Add application code
WORKDIR /app/max_weather
COPY ./requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY ./app.py app.py
EXPOSE 5000
ENTRYPOINT ["python"]
CMD ["app.py"]