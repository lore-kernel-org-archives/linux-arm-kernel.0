From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Wed, 15 Feb 2017 15:50:11 -0600
Subject: [PATCH 0/5] Add Arria10 System Manager Reset Controller
Message-ID: <1487195416-23827-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This series of patches adds the Altera Arria10 Development Kit System
Manager Reset Controller.

Thor Thayer (5):
  dt-bindings: mfd: Add Altera Arria10 SR Reset Controller bindings
  dt-bindings: Add Arria10 System Resource reset manager offsets
  reset: Add Altera Arria10 System Resource Reset Controller
  mfd: altr_a10sr: Add Arria10 DevKit Resource Controller
  ARM: socfpga: dts: Add Devkit A10-SR Reset Controller

 .../devicetree/bindings/mfd/altera-a10sr.txt       |  11 ++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       |   5 +
 drivers/mfd/altera-a10sr.c                         |   4 +
 drivers/reset/Kconfig                              |   7 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-a10sr.c                        | 176 +++++++++++++++++++++
 include/dt-bindings/reset/altr,rst-mgr-a10sr.h     |  31 ++++
 8 files changed, 237 insertions(+)
 create mode 100644 drivers/reset/reset-a10sr.c
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr-a10sr.h

-- 
1.9.1
