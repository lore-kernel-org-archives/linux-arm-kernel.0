From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Mon, 19 Jun 2017 15:36:55 -0500
Subject: [PATCHv4 0/3] Add Altera I2C Controller Driver
Message-ID: <1497904618-27010-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This patch series adds the Altera I2C Controller driver for use in FPGAs.
The device tree patch was removed in this version because this I2C is not
the default I2C master.

Thor Thayer (3):
  MAINTAINERS: Add Altera I2C Controller Driver
  dt-bindings: i2c: Add Altera I2C Controller
  i2c: altera: Add Altera I2C Controller driver

 .../devicetree/bindings/i2c/i2c-altera.txt         |  39 ++
 MAINTAINERS                                        |   5 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-altera.c                    | 511 +++++++++++++++++++++
 5 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt
 create mode 100644 drivers/i2c/busses/i2c-altera.c

-- 
2.7.4
