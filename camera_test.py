import time

from picamera2 import Picamera2

picam2 = Picamera2()

camera_config = picam2.create_still_configuration(main={"size": (1920, 1080)})
picam2.configure(camera_config)

picam2.start()
time.sleep(2)

metadata = picam2.capture_file("/app/test2.png")
print(metadata)

picam2.close()
