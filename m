From: jonmason@broadcom.com (Jon Mason)
Date: Wed, 21 Oct 2015 19:08:50 -0400
Subject: [PATCH 0/3] ARM: dts: NSP: Add PCI, NAND, and TWD Support to DT
Message-ID: <1445468933-25933-1-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PCI, NAND, and TWD Support to the Broadcom Northstar Plus SoC device 
tree file.  Since no driver changes are needed to enable these pieces of 
hardware, only the device tree changes are required to make them 
functional.


Jon Mason (3):
  ARM: dts: NSP: Add PCI support
  ARM: dts: NSP: Add NAND Support to DT
  ARM: dts: NSP: Add TWD Support to DT

 arch/arm/boot/dts/bcm-nsp.dtsi   | 104 ++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/bcm958625k.dts |  50 +++++++++++++++++++
 2 files changed, 153 insertions(+), 1 deletion(-)

-- 
1.9.1
