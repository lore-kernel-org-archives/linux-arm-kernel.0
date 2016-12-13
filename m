From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 13 Dec 2016 13:13:44 -0500
Subject: [PATCH 0/7] ARM: dts: NSP: DT Clean-ups and more
Message-ID: <1481652831-2744-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Northstar Plus device tree files have gotten messy and out of sync.
The first 5 patches correct this, the next 2 add support for new things.

Jon Mason (7):
  ARM: dts: NSP: DT Clean-ups
  ARM: dts: NSP: Correct NAND partition unit address
  ARM: dts: NSP: Add QSPI support to missing boards
  ARM: dts: NSP: Add BCM958625K switch ports
  ARM: dts: NSP: Add and enable amac2
  ARM: dts: NSP: Add Ethernet to NSP XMC
  ARM: dts: NSP: Add SD/MMC support

 arch/arm/boot/dts/bcm-nsp.dtsi     |  64 ++++++++++------
 arch/arm/boot/dts/bcm958522er.dts  |  35 ++++++++-
 arch/arm/boot/dts/bcm958525er.dts  |  35 ++++++++-
 arch/arm/boot/dts/bcm958525xmc.dts |  68 +++++++++++++----
 arch/arm/boot/dts/bcm958622hr.dts  |  42 +++++++++++
 arch/arm/boot/dts/bcm958623hr.dts  |  58 ++++++++++++--
 arch/arm/boot/dts/bcm958625hr.dts  |  72 ++++++++++++++----
 arch/arm/boot/dts/bcm958625k.dts   | 151 ++++++++++++++++++++++++++++---------
 arch/arm/boot/dts/bcm988312hr.dts  |  42 +++++++++++
 9 files changed, 472 insertions(+), 95 deletions(-)

-- 
2.7.4
