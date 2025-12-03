# importez sys pour accéder aux arguments de la ligne de commande si nécessaire
import sys
import os

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
# Une application néecessite une instance de QApplication.
# Passez sys.argv pour permettre les arguments de la ligne de commande.

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())

# L'application ne reviendra pas ici avant que vous ne quittiez et 
# que la boucle d'événements soit arrêtée.