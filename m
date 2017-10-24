From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Tue, 24 Oct 2017 10:06:59 +0530
Subject: [PATCH 0/3] Add driver for Broadcom Cygnus USB phy controller
Message-ID: <1508819822-29956-1-git-send-email-raveendra.padasalagi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add driver for Broadcom's USB phy controller's used in Cygnus family
of SoC and it's based on 4.14-rc3 tag.

The patch set can be fetched from iproc-cyg-usb-v1 branch of
https://github.com/Broadcom/arm64-linux.git

Raveendra Padasalagi (3):
  Documentation: DT: Add Cygnus usb phy binding
  drivers: phy: broadcom: Add driver for Cygnus USB phy controller
  ARM: dts: Add dt node for Broadcom Cygnus USB phy

 .../bindings/phy/brcm,cygnus-usb-phy.txt           | 101 ++++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  35 ++
 drivers/phy/broadcom/Kconfig                       |  14 +
 drivers/phy/broadcom/Makefile                      |   1 +
 drivers/phy/broadcom/phy-bcm-cygnus-usb.c          | 672 +++++++++++++++++++++
 5 files changed, 823 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
 create mode 100644 drivers/phy/broadcom/phy-bcm-cygnus-usb.c

-- 
1.9.1
