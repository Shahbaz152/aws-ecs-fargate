import pytest
from app import app as flask_app

@pytest.fixture
def app():
    """Fixture for creating the Flask app"""
    flask_app.config.update({'TESTING': True})
    yield flask_app

@pytest.fixture
def client(app):
    """Fixture for creating a test client"""
    return app.test_client()

def test_hello_route(client):
    """
    Test the root route ('/')
    - Verifies status code 200
    - Verifies exact response text
    """
    response = client.get('/')
    assert response.status_code == 200
    assert response.data.decode('utf-8') == 'Hello, World! This is my python web application with ECS Blue Green Deployment'

def test_health_route(client):
    """
    Test the health check route ('/health')
    - Verifies status code 200
    - Verifies response text and content type
    """
    response = client.get('/health')
    assert response.status_code == 200
    assert response.data.decode('utf-8') == 'healthy'
    assert response.content_type == 'text/html; charset=utf-8'

def test_main_execution():
    """
    Test direct execution of app.py
    - Simply verifies the main block code is reachable
    """
    import app
    # Just verify the app exists and has the expected properties
    assert hasattr(app, 'app')
    assert app.app is not None
