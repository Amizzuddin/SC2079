# original file consts.py
# to be replace by ENUM for readibility
# SYMBOL_MAP = {
#     "10": "Bullseye",
#     "11": "One",
#     "12": "Two",
#     "13": "Three",
#     "14": "Four",
#     "15": "Five",
#     "16": "Six",
#     "17": "Seven",
#     "18": "Eight",
#     "19": "Nine",
#     "20": "A",
#     "21": "B",
#     "22": "C",
#     "23": "D",
#     "24": "E",
#     "25": "F",
#     "26": "G",
#     "27": "H",
#     "28": "S",
#     "29": "T",
#     "30": "U",
#     "31": "V",
#     "32": "W",
#     "33": "X",
#     "34": "Y",
#     "35": "Z",
#     "36": "Up Arrow",
#     "37": "Down Arrow",
#     "38": "Right Arrow",
#     "39": "Left Arrow",
#     "40": "Stop"
# }


from enum import enum

class ImageId(enum):
    UP_ARROW = 1
    DOWN_ARROW = 
    RIGHT_ARROW = 
    LEFT_ARROW = 
    STOP = 
    BULLEYE = 
    ONE = 
    TWO = 
    THREE = 
    FOUR = 
    FIVE = 
    SIX = 
    SEVEN = 
    EIGHT = 
    NINE =
    A = 
    B = 
    C = 
    D = 
    E = 
    F = 
    G = 
    H = 
    I = 
    J = 
    K = 
    L = 
    M = 
    N = 
    O = 
    P = 
    Q = 
    R = 
    S =
    T = 
    U =
    V = 
    W = 
    X = 
    Y = 
    Z = 


class CommandVelocity:
    liner:
        x: float
        y: float
        z: float
    angular:
        roll: float = 0.0
        pitch: float = 0.0
        yaw: float = 0.0 # This should have some value since its 3 DOF robot


        



SYMBOL_MAP = {
    "10": "Bullseye",
    "11": "One",
    "12": "Two",
    "13": "Three",
    "14": "Four",
    "15": "Five",
    "16": "Six",
    "17": "Seven",
    "18": "Eight",
    "19": "Nine",
    "20": "A",
    "21": "B",
    "22": "C",
    "23": "D",
    "24": "E",
    "25": "F",
    "26": "G",
    "27": "H",
    "28": "S",
    "29": "T",
    "30": "U",
    "31": "V",
    "32": "W",
    "33": "X",
    "34": "Y",
    "35": "Z",
    "36": "Up Arrow",
    "37": "Down Arrow",
    "38": "Right Arrow",
    "39": "Left Arrow",
    "40": "Stop"
}