Media Converter
===============

Provides VLC with libraries for decoding DVDs and Bluray discs to MP4

## Usage

### Bluray

1. Cache the latest AACS key database

```
mkdir ./aacs
chown 1000:1000 aacs # UID/GID of the `vlc` user in the container
docker run --rm --volume ./aacs:/home/vlc/.config/aacs cache-keydb ghcr.io/jmanero/media-converter
```

1. Transcode to MP4 (h.264/AAC)

```
## Mount bluray media
mount /dev/sr0 /mnt/optical

## Use VLC to transcode the mounted bluray volume to an MP4 file
sudo docker run -d --rm --pull always \
  --volume ./aacs:/home/vlc/.config/aacs \
  --volume /mnt/optical:/media/optical \
  --volume /mnt/pond/media/converted:/media/converted \
  --net host ghcr.io/jmanero/media-converter \
  cvlc -vv bluray:///media/optical vlc://quit \
  --sout="#transcode{acodec=mp4a,ab=320,channels=6,samplerate=48000, vcodec=h264}:std{access=file, mux=mp4, dst=/media/converted/bluray.mp4}" \
  --intf http --http-password nothing --http-host 0.0.0.0 --http-port 8234
```
