# import logging

# def prepare_logger() -> logging.Logger:
#     """
#     Creates a logger that is able to both print to console and save to file.
#     """
#     log_format = logging.Formatter(
#         '%(asctime)s :: %(levelname)s :: %(message)s')

#     logger = logging.getLogger(__name__)
#     logger.setLevel(logging.DEBUG)

#     if not logger.hasHandlers():
#         # Console handler
#         console_handler = logging.StreamHandler()
#         console_handler.setLevel(logging.DEBUG)
#         console_handler.setFormatter(log_format)

#         # File handler
#         file_handler = logging.FileHandler('logfile.txt')
#         file_handler.setLevel(logging.DEBUG)
#         file_handler.setFormatter(log_format)

#         # Add handlers to logger
#         logger.addHandler(console_handler)
#         logger.addHandler(file_handler)

#     return logger


import logging
import sys
import time
from datetime import timedelta
from enum import Enum

logger = logging.getLogger("sc2006_project")
logger.setLevel(logging.DEBUG)
logger.propagate = True  # This is needed for pytest caplog fixture (log output assertion)
# this will autoflush every command

handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.DEBUG)


class LoggerColor(Enum):
    RED = "\x1b[31;20m"
    GREEN = "\x1b[32;20m"
    YELLOW = "\x1b[33;20m"
    BLUE = "\x1b[34;20m"
    RESET = "\x1b[0m"


class ElapsedFormatter(logging.Formatter):
    # https://stackoverflow.com/questions/25194864/python-logging-time-since-start-of-program

    COLORS = {
        "DEBUG": LoggerColor.BLUE.value,
        "WARNING": LoggerColor.YELLOW.value,
        "ERROR": LoggerColor.RED.value,
        "CRITICAL": LoggerColor.RED.value,
    }

    def __init__(self, format: str) -> None:
        super().__init__(format)
        self.start_time = time.time()

    def format(self, record: logging.LogRecord) -> str:
        if record.levelname in self.COLORS:
            levelname_color = self.COLORS[record.levelname] + record.levelname + LoggerColor.RESET.value
            record.levelname = levelname_color

        elapsed_seconds = record.created - self.start_time

        # using timedelta here for convenient default formatting
        elapsed = timedelta(seconds=elapsed_seconds)
        record.delta = elapsed

        # return "{} {}".format(elapsed, record.getMessage())
        return super().format(record)


format = "%(delta)s %(levelname)s [%(filename)s:%(lineno)d] %(message)s"
elapsed_formatter = ElapsedFormatter(format)
handler.setFormatter(elapsed_formatter)
logger.addHandler(handler)
