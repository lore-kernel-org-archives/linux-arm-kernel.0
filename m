From: rogerq@ti.com (Roger Quadros)
Date: Tue, 7 Jan 2014 17:44:45 +0530
Subject: [PATCH v3 0/4] USB Host support for OMAP5 uEVM (for 3.14)
Message-ID: <1389096889-22179-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit & Tony,

This patchset brings up USB Host ports and Ethernet port on
the OMAP5 uEVM board.

It depends on the TI Clock DT conversion patches [1].

[1] - http://article.gmane.org/gmane.linux.ports.arm.kernel/289895

cheers,
-roger

Roger Quadros (4):
  ARM: dts: OMAP5: Add 60MHz clock reference to USB Host module
  ARM: dts: omap4-panda: Provide USB PHY clock
  ARM: dts: omap5-uevm: Provide USB PHY clock
  ARM: OMAP2+: Remove legacy_init_ehci_clk()

 arch/arm/boot/dts/omap4-panda-common.dtsi |  8 ++------
 arch/arm/boot/dts/omap5-uevm.dts          |  8 ++------
 arch/arm/boot/dts/omap5.dtsi              |  2 ++
 arch/arm/mach-omap2/pdata-quirks.c        | 16 ----------------
 4 files changed, 6 insertions(+), 28 deletions(-)

-- 
1.8.3.2
