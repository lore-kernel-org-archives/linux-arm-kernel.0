From: eric@anholt.net (Eric Anholt)
Date: Mon, 28 Dec 2015 21:01:20 -0800
Subject: [GIT PULL 2/4] BCM2835 drivers changes for 4.5
In-Reply-To: <1451365282-10505-1-git-send-email-eric@anholt.net>
References: <1451365282-10505-1-git-send-email-eric@anholt.net>
Message-ID: <1451365282-10505-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f74875dc36135ebae82a8e005f4b7f52289d2c40:

  usb: dwc2: fix kernel oops during driver probe (2015-11-20 09:29:47 -0600)

are available in the git repository at:

  http://github.com/anholt/linux tags/bcm2835-drivers-next-2015-12-28

for you to fetch changes up to a09cd356586d33f64cbe64ee4f5c1a7c4a6abee5:

  ARM: bcm2835: add rpi power domain driver (2015-12-21 20:00:41 -0800)

----------------------------------------------------------------
This pull request includes the bcm2835 changes for 4.5 targeting the
arm-soc next/drivers branch.

----------------------------------------------------------------
Alexander Aring (2):
      dt-bindings: add rpi power domain driver bindings
      ARM: bcm2835: add rpi power domain driver

Eric Anholt (1):
      ARM: bcm2835: Define two new packets from the latest firmware.

 .../bindings/soc/bcm/raspberrypi,bcm2835-power.txt |  47 ++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/bcm/Kconfig                            |   9 +
 drivers/soc/bcm/Makefile                           |   1 +
 drivers/soc/bcm/raspberrypi-power.c                | 247 +++++++++++++++++++++
 include/dt-bindings/power/raspberrypi-power.h      |  41 ++++
 include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
 8 files changed, 349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
 create mode 100644 drivers/soc/bcm/Kconfig
 create mode 100644 drivers/soc/bcm/Makefile
 create mode 100644 drivers/soc/bcm/raspberrypi-power.c
 create mode 100644 include/dt-bindings/power/raspberrypi-power.h
