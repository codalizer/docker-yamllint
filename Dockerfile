FROM python:3.9-alpine3.15

RUN pip install yamllint

ENTRYPOINT ["yamllint"]