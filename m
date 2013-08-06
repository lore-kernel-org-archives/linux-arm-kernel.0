From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 6 Aug 2013 14:03:01 +0530
Subject: [PATCH 0/3] ARM: AM33xx: Add RNG module data
Message-ID: <1375777984-6267-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds HWMOD, CLOCK and DT data for
RNG module.

Lokesh Vutla (3):
  ARM: AM33XX: hwmod: Add rng module data
  ARM: AM33xx: Add rng clock data
  ARM: dts: AM33xx: Add RNG node

 .../devicetree/bindings/hwrng/omap_rng.txt         |   22 ++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |    4 +++
 arch/arm/boot/dts/am335x-evm.dts                   |    4 +++
 arch/arm/boot/dts/am335x-evmsk.dts                 |    4 +++
 arch/arm/boot/dts/am33xx.dtsi                      |    8 +++++
 arch/arm/mach-omap2/cclock33xx_data.c              |    5 +++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   35 ++++++++++++++++++++
 7 files changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwrng/omap_rng.txt

-- 
1.7.9.5
