# Virtual customers

This part creates virtual customers, and generate customers traffic/action.

## Run locally

```bash
# Use Docker for RabbitMQ locally
docker run -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3-management

# Running the app
ruby app.rb
```
