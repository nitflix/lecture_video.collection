from __future__ import unicode_literals
from flask import Flask
import youtube_dl


class MyLogger(object):
    def debug(self, msg):
        pass

    def warning(self, msg):
        pass

    def error(self, msg):
        print(msg)


def my_hook(d):
    if d['status'] == 'finished':
        print('Done downloading, now converting ...')


app = Flask(__name__)

@app.route("/video")
def get_video():
    # ydl_opts = {
    #     'format': 'bestaudio/best',
    #     'postprocessors': [{
    #         'key': 'FFmpegExtractAudio',
    #         'preferredcodec': 'mp3',
    #         'preferredquality': '192',
    #     }],
    #     'logger': MyLogger(),
    #     'progress_hooks': [my_hook],
    # }
    remote_resource_url = request.args.get('video')
    with youtube_dl.YoutubeDL(ydl_opts) as ydl:
            ydl.download([remote_resource_url])
    return "OK"
