From: r.sricharan@ti.com (Sricharan R)
Date: Thu, 6 Jun 2013 23:18:35 +0530
Subject: [PATCH V2 0/4] ARM: dts: omap5: Cleanup and updates for DT files
Message-ID: <1370540919-4339-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

uevm is the official board supported for OMAP5 soc in the mainline.
This series renames the board dts file for OMAP5 accordingly and cleans
up the same. Also a few additional device DT entry updates are done.

This is on top of the below branch
    git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
    for_3.11/dts

Boot tested on omap5-uevm after pulling in the data from below place
    git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git
    HWMOD DATA: for_3.11/omap5_data_files
    CLOCK DATA: out_of_tree/omap5_clk_data

Dan Murphy (1):
  ARM: dts: omap5-uevm: Add LED support for uEVM blue LED

Roger Quadros (1):
  ARM: dts: omap5-uevm: Add USB Host support

Sourav Poddar (1):
  ARM: dts: omap5-uevm: Add uart pinctrl data

Sricharan R (1):
  ARM: dts: omap5: Rename omap5-evm to omap5-uevm

 arch/arm/boot/dts/Makefile       |    2 +-
 arch/arm/boot/dts/omap5-evm.dts  |  261 --------------------------------
 arch/arm/boot/dts/omap5-uevm.dts |  311 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi     |   30 ++++
 4 files changed, 342 insertions(+), 262 deletions(-)
 delete mode 100644 arch/arm/boot/dts/omap5-evm.dts
 create mode 100644 arch/arm/boot/dts/omap5-uevm.dts

-- 
1.7.9.5
