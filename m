From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Fri,  2 Jun 2017 18:52:35 -0500
Subject: [PATCHv3 0/4] Add Altera I2C Controller Driver
Message-ID: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This patch seris add the Altera I2C Controller driver for use in FPGAs.

Thor Thayer (4):
  ARM: dts: socfpga: Add Altera I2C Controller to CycloneV
  MAINTAINERS: Add Altera I2C Controller Driver
  dt-bindings: i2c: Add Altera I2C Controller
  i2c: altera: Add Altera I2C Controller driver

 .../devicetree/bindings/i2c/i2c-altera.txt         |  39 ++
 MAINTAINERS                                        |   5 +
 arch/arm/boot/dts/socfpga.dtsi                     |  13 +-
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |  28 +-
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-altera.c                    | 509 +++++++++++++++++++++
 7 files changed, 601 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt
 create mode 100644 drivers/i2c/busses/i2c-altera.c

-- 
2.7.4
