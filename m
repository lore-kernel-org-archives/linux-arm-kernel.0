From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Wed, 22 Feb 2017 11:10:14 -0600
Subject: [PATCHv2 0/5] Add Arria10 System Manager Reset Controller 
Message-ID: <1487783419-10912-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This series of patches adds the Altera Arria10 Development Kit System
Resource Chip's Reset Controller.

Thor Thayer (5):
  dt-bindings: mfd: Add Altera Arria10 SR Reset Controller bindings
  dt-bindings: reset: a10sr: Add Arria10 SR Reset Controller offsets
  reset: Add Altera Arria10 SR Reset Controller
  mfd: altr_a10sr: Add Arria10 DevKit Reset Controller
  ARM: dts: socfpga: Add Devkit A10-SR Reset Controller

 .../devicetree/bindings/mfd/altera-a10sr.txt       |  11 ++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       |   5 +
 drivers/mfd/altera-a10sr.c                         |   4 +
 drivers/reset/Kconfig                              |   7 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-a10sr.c                        | 138 +++++++++++++++++++++
 include/dt-bindings/reset/altr,rst-mgr-a10sr.h     |  33 +++++
 8 files changed, 201 insertions(+)
 create mode 100644 drivers/reset/reset-a10sr.c
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr-a10sr.h

-- 
1.9.1
