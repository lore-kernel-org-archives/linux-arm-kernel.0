From: marex@denx.de (Marek Vasut)
Date: Mon, 19 Sep 2016 23:40:43 +0200
Subject: [PATCH 3/4] ARM: dts: socfpga: Add new MCVEVK manufacturer compat
In-Reply-To: <20160919214044.9615-1-marex@denx.de>
References: <20160919214044.9615-1-marex@denx.de>
Message-ID: <20160919214044.9615-3-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board is now manufactured by Aries Embedded GmbH, update compat string.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi   | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
index f86f9c0..6ad3b1e 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
@@ -18,7 +18,7 @@
 #include "socfpga_cyclone5.dtsi"
 
 / {
-	model = "DENX MCV";
+	model = "Aries/DENX MCV";
 	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
 
 	memory {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
index caa40cf..8882314 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
@@ -18,7 +18,7 @@
 #include "socfpga_cyclone5_mcv.dtsi"
 
 / {
-	model = "DENX MCV EVK";
+	model = "Aries/DENX MCV EVK";
 	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
 
 	aliases {
-- 
2.9.3
