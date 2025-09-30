from flask import Flask
import redis

app = Flask(__name__)
# Conexión al servicio 'db' (Redis)
cache = redis.Redis(host='db', port=6379)

def get_hit_count():
    try:
        return cache.incr('visits') # Usamos 'visits' como clave
    except Exception:
        return "error"

@app.route('/')
def hello():
    count = get_hit_count()
    if count == "error":
        html = "<h2>V1.0 - ¡Despliegue con Error!</h2><b>Redis no está conectado.</b>"
    else:
        html = "<h2>¡Automatización Total Lograda! - V4.0 🤖</h2>El contador es: <b>{0}</b>"

    return html.format(count)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)