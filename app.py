from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, World! This is my python web application with ECS Blue=Green--done--'

@app.route('/health')
def health():
    return 'healthy', 200

if __name__ == '__main__':
    pragma: no cover
    app.run(host='0.0.0.0', port=5000)
