from dataclasses import dataclass
from PySide6.QtCore import QAbstractListModel, QModelIndex, Qt, Slot, Signal, QSortFilterProxyModel


@dataclass
class Todo:
    text: str
    completed: bool = False

class ProxyTodoModel(QSortFilterProxyModel):
    def __init__(self, completed, parent=None):
        super().__init__(parent)
        self._completed = completed
    
    def filterAcceptsRow(self, source_row: int, source_parent: QModelIndex) -> bool:
        index = self.sourceModel().index(source_row, 0, source_parent)
        return index.data(TodoModel.CompletedRole) == self._completed


class TodoModel(QAbstractListModel):
    CompletedRole = Qt.UserRole + 1

    def __init__(self, todos=None):
        super().__init__()
        self._todos = todos or []

    def data(self, index: QModelIndex, role: int = Qt.DisplayRole):
        # if not index.isValid() or not (0 <= index.row() < len(self._todos)):
        #     return None

        todo = self._todos[index.row()]

        if role == Qt.ItemDataRole.DisplayRole:
            return todo.text
        elif role == self.CompletedRole:
            return todo.completed

        return None

    def rowCount(self, parent=QModelIndex()):
        return len(self._todos)

    def roleNames(self):
        roles = super().roleNames()
    #     roles[self.TitleRole] = b"title"
        roles[self.CompletedRole] = b"completed"
        return roles
    
    def flags(self, index):
        if not index.isValid():
            return Qt.NoItemFlags
        return (
            Qt.ItemIsEnabled
            | Qt.ItemIsSelectable
            | Qt.ItemIsEditable
        )
    
    def setData(self, index: QModelIndex, value, role):
        if not index.isValid():
            return False
        if role == self.CompletedRole:
            self._todos[index.row()].completed = value
            self.dataChanged.emit(index, index, [role])
            return True
        
        return False
