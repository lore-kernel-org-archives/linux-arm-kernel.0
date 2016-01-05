From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 5 Jan 2016 14:26:43 -0600
Subject: [PATCH] ARM: dts: socfpga: add cap-sd-highspeed for SD/MMC node
Message-ID: <1452025603-8801-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Enable SD highspeed support for the SoCFPGA Arria10 devkit.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
index dbbb751..8a7dfa4 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
@@ -21,6 +21,7 @@
 &mmc {
 	status = "okay";
 	num-slots = <1>;
+	cap-sd-highspeed;
 	broken-cd;
 	bus-width = <4>;
 };
-- 
2.6.2
