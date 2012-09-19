From: anilkumar@ti.com (AnilKumar Ch)
Date: Thu, 20 Sep 2012 02:49:25 +0530
Subject: [PATCH RESEND 0/5] ARM: dts: AM33XX: Add device tree data
Message-ID: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree data of pinctrl, d_can, lis331dlh and tmp275 drivers
for AM33XX family of devices. These patches were submitted earlier
and reviewed. Re-sending to apply cleanly on linux-omap/devel-dt
tree. These patches were tested on am33xx-evm and am335x-bone.

AnilKumar Ch (5):
  ARM: dts: AM33XX: Add basic pinctrl device tree data
  ARM: dts: AM33XX: Add D_CAN device tree data
  ARM: OMAP2+: AM33XX: Add clock entries to omap_clk data
  ARM: dts: AM33XX: Add lis331dlh device tree data to am335x-evm
  ARM: dts: AM33XX: Add temperature sensor device tree data to
    am335x-evm

 arch/arm/boot/dts/am335x-evm.dts     |   44 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi        |   27 +++++++++++++++++++++
 arch/arm/mach-omap2/clock33xx_data.c |    1 +
 3 files changed, 72 insertions(+)

-- 
1.7.9.5
