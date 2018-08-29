From: marex@denx.de (Marek Vasut)
Date: Wed, 29 Aug 2018 17:15:04 +0200
Subject: [PATCH] ARM: dts: socfpga: Rename socfpga_cyclone5_de0_{sockit,
 nano_soc}
Message-ID: <20180829151504.12013-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename DT source for DE0 Nano SoC . The board name is really DE0-Nano-SoC
or Atlas SoC, and it is not to be confused with SoCkit board, which is a
different one. Rename the DT source file to match the board name and to
avoid this possible mixup with another different board.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/boot/dts/Makefile                                      | 2 +-
 ...yclone5_de0_sockit.dts => socfpga_cyclone5_de0_nano_soc.dts} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/boot/dts/{socfpga_cyclone5_de0_sockit.dts => socfpga_cyclone5_de0_nano_soc.dts} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 92dc4f05cf23..af881dce7ab4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -892,7 +892,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_arria10_socdk_sdmmc.dtb \
 	socfpga_cyclone5_mcvevk.dtb \
 	socfpga_cyclone5_socdk.dtb \
-	socfpga_cyclone5_de0_sockit.dtb \
+	socfpga_cyclone5_de0_nano_soc.dtb \
 	socfpga_cyclone5_sockit.dtb \
 	socfpga_cyclone5_socrates.dtb \
 	socfpga_cyclone5_sodia.dtb \
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
rename to arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
-- 
2.18.0
