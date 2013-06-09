From: 21cnbao@gmail.com (Barry Song)
Date: Sun,  9 Jun 2013 11:25:35 +0800
Subject: [PATCH 0/3] usb: add CSR SiRFSoC usb controller and phy support
Message-ID: <1370748338-13210-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds CSR SiRFSoC usb controller and phy support.
For USB controller, CSR licensed chipidea IP core.

Rong Wang (3):
  usb: chipidea: add CSR SiRFSoC ci13xxx usb driver
  usb: phy: add driver for CSR SiRFSoC internal phy
  arm/dts: atlas6: fix the stuff of USB controller and phy

 arch/arm/boot/dts/atlas6.dtsi       |   18 ++--
 drivers/usb/Kconfig                 |    1 +
 drivers/usb/chipidea/Kconfig        |   25 ++++
 drivers/usb/chipidea/Makefile       |    5 +-
 drivers/usb/chipidea/ci13xxx_sirf.c |  223 +++++++++++++++++++++++++++++++++++
 drivers/usb/phy/Kconfig             |   10 ++
 drivers/usb/phy/Makefile            |    1 +
 drivers/usb/phy/phy-sirf-usb.c      |  198 +++++++++++++++++++++++++++++++
 8 files changed, 471 insertions(+), 10 deletions(-)
 create mode 100644 drivers/usb/chipidea/ci13xxx_sirf.c
 create mode 100644 drivers/usb/phy/phy-sirf-usb.c

-- 
1.7.5.4
