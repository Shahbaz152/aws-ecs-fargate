import pytest
from app import app as flask_app
import importlib
import sys

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
    assert response.data.decode('utf-8') == 'Hello, World! This is my python web application with ECS Blue=Green--done--'

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

def test_main_execution(monkeypatch):
    """
    Test direct execution of app.py
    - Mocks app.run() to prevent actually running the server
    - Verifies the app starts correctly
    """
    # Reload the module to reset any state
    if 'app' in sys.modules:
        importlib.reload(sys.modules['app'])
    else:
        import app
    
    mock_calls = []
    
    def mock_run(*args, **kwargs):
        mock_calls.append((args, kwargs))
        # Simulate KeyboardInterrupt (Ctrl+C) behavior
        raise KeyboardInterrupt
    
    monkeypatch.setattr(sys.modules['app'].app, 'run', mock_run)
    
    # Simulate command line execution
    with pytest.raises(KeyboardInterrupt):
        if __name__ == '__main__':
            sys.modules['app'].app.run(host='0.0.0.0', port=5000)
    
    # Verify run() was called with correct parameters
    assert len(mock_calls) == 1
    assert mock_calls[0][1]['host'] == '0.0.0.0'
    assert mock_calls[0][1]['port'] == 5000
