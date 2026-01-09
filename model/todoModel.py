from dataclasses import dataclass
from PySide6.QtCore import QAbstractListModel, QModelIndex, Qt

@dataclass
class Todo:
    text: str
    # completed: bool = False


class TodoModel(QAbstractListModel):
    # TitleRole = Qt.UserRole + 1
    # CompletedRole = Qt.UserRole + 2

    def __init__(self, todos=None):
        super().__init__()
        self._todos = todos or []

    def data(self, index: QModelIndex, role: int = Qt.DisplayRole):
        # if not index.isValid() or not (0 <= index.row() < len(self._todos)):
        #     return None

        todo = self._todos[index.row()]

        if role == Qt.ItemDataRole.DisplayRole:
            return todo.text
        # elif role == self.CompletedRole:
        #     return todo.completed

        return None

    def rowCount(self, parent=QModelIndex()):
        return len(self._todos)

    # def roleNames(self):
    #     roles = super().roleNames()
    #     roles[self.TitleRole] = b"title"
    #     # roles[self.CompletedRole] = b"completed"
    #     return roles
