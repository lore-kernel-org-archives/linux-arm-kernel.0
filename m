From: jon.mason@broadcom.com (Jon Mason)
Date: Fri, 28 Apr 2017 16:29:38 -0400
Subject: [PATCH 0/3] USB3 support for Broadcom NS2 SoC
Message-ID: <1493411381-16833-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set contains the USB3 support for Broadcom NS2 SoC.  The USB3
PHY is connected through the MDIO interface.

Yendapally Reddy Dhananjaya Reddy (3):
  dt-bindings: phy: Add documentation for NS2 USB3 PHY
  phy: Add USB3 PHY support for Broadcom NS2 SoC
  arm64: dts: ns2: Add USB3 Support

 .../devicetree/bindings/phy/brcm,ns2-usb3-phy.txt  |  82 +++
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |  16 +
 arch/arm64/boot/dts/broadcom/ns2-xmc.dts           |   8 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  62 +++
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-bcm-ns2-usb3.c                     | 596 +++++++++++++++++++++
 7 files changed, 774 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns2-usb3-phy.txt
 create mode 100644 drivers/phy/phy-bcm-ns2-usb3.c

-- 
2.7.4
