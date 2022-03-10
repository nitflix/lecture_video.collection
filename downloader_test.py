import youtube_dl

with youtube_dl.YoutubeDL({"forcethumnail": True}) as ydl:
    ydl.download(['ytsearch:Introduction to computer science and programming in python. Fall 2016'])
