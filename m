From: josh.wu@atmel.com (Josh Wu)
Date: Fri, 28 Nov 2014 18:28:23 +0800
Subject: [PATCH 0/4] media: ov2640: add device tree support
Message-ID: <1417170507-11172-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add device tree support for ov2640. And also add
the document for the devicetree properties.

Josh Wu (4):
  media: ov2640: add async probe function
  media: ov2640: add primary dt support
  media: ov2640: add a master clock for sensor
  media: ov2640: dt: add the device tree binding document

 .../devicetree/bindings/media/i2c/ov2640.txt       |  43 ++++++
 drivers/media/i2c/soc_camera/ov2640.c              | 151 ++++++++++++++++++---
 2 files changed, 178 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov2640.txt

-- 
1.9.1
