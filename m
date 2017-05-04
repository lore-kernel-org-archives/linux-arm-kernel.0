From: marex@denx.de (Marek Vasut)
Date: Thu,  4 May 2017 12:29:50 +0200
Subject: [PATCH 4/4] ARM: dts: socfpga: Add second ethernet alias to VINING
 FPGA
In-Reply-To: <20170504102950.10667-1-marex@denx.de>
References: <20170504102950.10667-1-marex@denx.de>
Message-ID: <20170504102950.10667-4-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT alias for the second ethernet present on mainboard rev 1.10.

Signed-off-by: Marek Vasut <marex@denx.de>
---
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
index 9195f11dacdc..655fe87e272d 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
@@ -69,6 +69,7 @@
 		 * to be added to the gmac1 device tree blob.
 		 */
 		ethernet0 = &gmac1;
+		ethernet1 = &gmac0;
 	};
 
 	gpio-keys {
-- 
2.11.0
