#!/bin/bash

# ==========================================
# Todo App Docker Compose Manager (Linux/macOS)
# Usage: ./manage.sh start|stop|restart|clean
# ==========================================

URL="http://localhost:8080"

if [ -z "$1" ]; then
    echo "Usage: $0 start|stop|restart|clean"
    exit 1
fi

case "$1" in
    start)
        echo "=========================================="
        echo "Starting Todo App..."
        echo "=========================================="
        docker-compose up --build -d
        echo "Todo App is running at $URL"
        xdg-open $URL 2>/dev/null || open $URL 2>/dev/null || echo "Open browser manually"
        ;;

    stop)
        echo "=========================================="
        echo "Stopping Todo App..."
        echo "=========================================="
        docker-compose down
        echo "Containers stopped."
        ;;

    restart)
        echo "=========================================="
        echo "Restarting Todo App..."
        echo "=========================================="
        docker-compose down
        docker-compose up --build -d
        echo "Todo App restarted at $URL"
        xdg-open $URL 2>/dev/null || open $URL 2>/dev/null || echo "Open browser manually"
        ;;

    clean)
        echo "=========================================="
        echo "Cleaning Docker environment..."
        echo "=========================================="
        docker-compose down --volumes --rmi all
        echo "Containers, volumes, and images removed."
        ;;

    *)
        echo "Invalid option: $1"
        echo "Usage: $0 start|stop|restart|clean"
        exit 1
        ;;
esac
