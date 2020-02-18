import math
def playmaze(maze, size):
    move = input("Select direction to move\n")
    if (MoveChar(maze, move,size) == True):
        print("congratulations you win")
    else:
        printmaze(maze, size)
        playmaze(maze, size)

def MoveChar(maze, move, size):
    for row in range(0,size):
        for col in range(0,size):
            if maze[row][col] == 2:
                if move == 's':
                    if (row != size) and (maze[row+1][col] == 1):
                        maze[row+1][col] = 2
                        maze[row][col] = 1
                        return False
                    elif maze[row+1][col] == 3:
                        return True
                if move == 'a':
                    if (col != 0) and (maze[row][col-1] == 1):
                        maze[row][col-1] = 2
                        maze[row][col] = 1
                        return False
                    elif maze[row][col-1] == 3:
                        return True
                if move == 'w':
                    if (row != 0) and (maze[row-1][col] == 1):
                        maze[row-1][col] = 2
                        maze[row][col] = 1
                        return False
                    elif maze[row-1][col] == 3:
                        return True
                if move == 'd':
                    if (col != size) and (maze[row][col+1] == 1):
                        maze[row][col+1] = 2
                        maze[row][col] = 1
                        return False
                    elif maze[row][col+1] == 3:
                        return True
    return False
def printmaze(maze,size):
    for num in range(0, size+2):
        print(' ',"#", ' ', end='')
    print('\n')
    for row in range(0,size):
        for col in range(0,size):
            if col == 0:
                print(' ',"#", ' ', end='')
            if (maze[row][col] == 1):
                print(' ',"M", ' ', end='')
            if (maze[row][col] == 0):
                print(' ',"#", ' ', end='')
            if (maze[row][col] == 2):
                print(' ',"O", ' ', end='')
            if (maze[row][col] == 3):
                print(' ',"X", ' ', end='')
            if col == size-1:
                print(' ',"#", ' ', end='')
        print('\n')
    for num in range(0, size+2):
        print(' ',"#", ' ', end='')
    print('\n')
def main():
    maze = [[2, 1, 0, 0],
            [1, 1, 0, 1],
            [0, 1, 0, 0],
            [1, 1, 1, 3]];
    print("maze loaded")
    size = 4
    printmaze(maze, size)
    playmaze(maze, size)
main()
