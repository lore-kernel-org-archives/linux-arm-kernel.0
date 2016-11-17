From: jon.mason@broadcom.com (Jon Mason)
Date: Thu, 17 Nov 2016 18:25:01 -0500
Subject: [PATCH 0/2] arm64: dts: NS2: Add sdio1, PCI phys
Message-ID: <1479425103-2119-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second SDIO seems to have been forgotten to be enabled in the
Northstar2 SVK dts.  Also, the PCI PHY entries are missing from the PCI
bus device tree entries.

Jon Mason (2):
  arm64: dts: NS2: enable sdio1
  arm64: dts: NS2: Add PCI PHYs

 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 4 ++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 6 ++++++
 2 files changed, 10 insertions(+)

-- 
2.7.4
