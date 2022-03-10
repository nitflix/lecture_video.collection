from __future__ import unicode_literals
import youtube_dl
from flask import Flask

ydl_opts = {}
with youtube_dl.YoutubeDL(ydl_opts) as ydl:
        ydl.download(['https://www.youtube.com/watch?v=BaW_jenozKc'])

import os

app = Flask(__name__)

@app.route("/")
def get_thumbnail():
        return "<p>Hello, World!</p>"
