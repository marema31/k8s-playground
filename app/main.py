import time
import os
from flask import Flask

app = Flask(__name__)
wait_time = int(os.environ.get("WAIT_TIME", 60 * 10))
print(f"Wait time: {wait_time}")


@app.route("/health")
def healthcheck():
    return "OK"


@app.route("/")
def hello_world():
    return "Hello, World!"


@app.route("/wait")
def wait():
    print(f"will wait {wait_time}")
    time.sleep(wait_time)
    return "Hello, World!"


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")
