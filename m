From: jon.mason@broadcom.com (Jon Mason)
Date: Tue,  7 Jun 2016 18:28:05 -0400
Subject: [PATCH 0/2] ARM: dts: NSP: add PL330 support and XMC board
Message-ID: <1465338487-14932-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the PL330 DMA engine and the XMC form factor for
Broadcom Northstar Plus SoCs


Jon Mason (2):
  ARM: dts: NSP: Add XMC board support
  ARM: dts: NSP: Add PL330 support

 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/bcm-nsp.dtsi     |  17 ++++++
 arch/arm/boot/dts/bcm958525xmc.dts | 109 +++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm958525xmc.dts

-- 
1.9.1
