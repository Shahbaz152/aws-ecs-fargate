from app import app
import pytest

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_hello_route(client):
    """Test the main hello route"""
    response = client.get('/')
    assert response.status_code == 200
    assert b"Hello, World! This is my python web application with ECS Blue=Green--done--" in response.data

def test_health_route(client):
    """Test the health check route"""
    response = client.get('/health')
    assert response.status_code == 200
    assert b"healthy" in response.data

def test_app_execution():
    """Test the app can be executed directly"""
    import app as application
    assert application.app is not None
    with application.app.test_client() as test_client:
        response = test_client.get('/')
        assert response.status_code == 200
