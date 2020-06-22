FROM nickblah/lua:5.1-alpine3.9
RUN apk add ruby ruby-rdoc
WORKDIR /app
COPY . /app
RUN gem install bundler:1.11.2
RUN bundle install
ENTRYPOINT [ "cucumber" ]
