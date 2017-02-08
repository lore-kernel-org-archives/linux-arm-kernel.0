From: jon.mason@broadcom.com (Jon Mason)
Date: Wed,  8 Feb 2017 15:45:14 -0500
Subject: [PATCH 0/2] ARM: dts: BCM5301X: QSPI and NAND
Message-ID: <1486586716-6781-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the default SPI of the BCM5301X to be the new(-ish) iProc QSPI
driver.  Testing limited to internal Broadcom systems.  So, this might\
need extended testing (though I epxect it to work).

Also, Add NAND to bcm953012k

Jon Mason (2):
  ARM: dts: BCM5301X: Add NAND entries to bcm953012k
  ARM: dts: BCM5301X: convert to iProc QSPI

 arch/arm/boot/dts/bcm5301x.dtsi  | 50 ++++++++++++++++++++++++----------
 arch/arm/boot/dts/bcm953012k.dts | 58 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 14 deletions(-)

-- 
2.7.4
