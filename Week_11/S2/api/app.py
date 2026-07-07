from flask import Flask

from routes.products import products_bp


app = Flask(__name__)

app.register_blueprint(products_bp)

@app.route("/")
def home():
    return{"Message":"Welcome to product API"}

for rule in app.url_map.iter_rules():
    print(f"{rule.endpoint:20}{rule.methods}{rule}")

if __name__ == "__main__":
    app.run(
        host='127.0.0.1',
        port=5001,
        debug = True

    )


