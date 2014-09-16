From: b.galvani@gmail.com (Beniamino Galvani)
Date: Wed, 17 Sep 2014 00:07:55 +0200
Subject: [PATCH 0/2] Amlogic Meson I2C driver
Message-ID: <1410905277-22172-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series adds a driver for the I2C controller found on Amlogic
Meson SoCs. It has been tested on a Tronsmart Vega S89 TV Box, which
is based on a Meson8 core, but should work also on Meson6 devices. 

A patchset adding support for these SoCs was submitted some days ago
and can be found here:

http://thread.gmane.org/gmane.linux.ports.arm.kernel/356685

Beniamino Galvani (2):
  i2c: add support for Amlogic Meson I2C controller
  i2c: meson: add device tree bindings documentation

 .../devicetree/bindings/i2c/i2c-meson.txt          |  24 +
 drivers/i2c/busses/Kconfig                         |   7 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-meson.c                     | 500 +++++++++++++++++++++
 4 files changed, 532 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-meson.txt
 create mode 100644 drivers/i2c/busses/i2c-meson.c

-- 
1.9.1
