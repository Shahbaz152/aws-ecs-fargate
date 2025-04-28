from app import app

def test_hello():
    tester = app.test_client()
    response = tester.get('/')
    assert response.status_code == 200
    assert b"Hello, World! This is my python web application with ECS Blue=Green--done--" in response.data

def test_health():
    tester = app.test_client()
    response = tester.get('/health')
    assert response.status_code == 200
    assert b"healthy" in response.data
