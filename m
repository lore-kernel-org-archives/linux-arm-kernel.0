From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Fri, 27 Oct 2017 15:42:18 +0800
Subject: [PATCH v2 0/2] media: ov7740: Add a V4L2 sensor-level driver
Message-ID: <20171027074220.23839-1-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Video4Linux2 sensor-level driver for the OmniVision OV7740
VGA camera image sensor.

Changes in v2:
 - Split off the bindings into a separate patch.
 - Add a new entry to the MAINTAINERS file.

Wenyou Yang (2):
  media: i2c: Add the ov7740 image sensor driver
  media: ov7740: Document device tree bindings

 .../devicetree/bindings/media/i2c/ov7740.txt       |   43 +
 MAINTAINERS                                        |    8 +
 drivers/media/i2c/Kconfig                          |    8 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/ov7740.c                         | 1220 ++++++++++++++++++++
 5 files changed, 1280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov7740.txt
 create mode 100644 drivers/media/i2c/ov7740.c

-- 
2.13.0
