From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 31 Aug 2012 15:07:18 +0530
Subject: [PATCH 0/2] ARM: OMAP2: AM33XX: Add cpufreq support
Message-ID: <1346405840-31058-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpufreq support to AM33XX family of devices by adding OPP
information, clock entry with cpu0 name and voltage supplies
to cpu0.

These patches have been tested on AM335x-EVM, AM335x-Bone and
these patches are based on cpufreq-cpu0 driver
http://marc.info/?l=linux-arm-kernel&m=134457735413293&w=2

AnilKumar Ch (2):
  ARM: OMAP2+: AM33XX: Add clock entries to omap_clk data
  arm/dts: AM33XX: Add device tree OPP table

 arch/arm/boot/dts/am335x-bone.dts    |    6 ++++++
 arch/arm/boot/dts/am335x-evm.dts     |    6 ++++++
 arch/arm/boot/dts/am33xx.dtsi        |   15 +++++++++++++++
 arch/arm/mach-omap2/clock33xx_data.c |    1 +
 4 files changed, 28 insertions(+)

-- 
1.7.9.5
