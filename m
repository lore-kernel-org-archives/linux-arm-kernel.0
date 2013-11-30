From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 30 Nov 2013 10:18:01 +0400
Subject: [PATCH 1/4] ARM: dts: imx27-phytec-phycore-som: Add on-flash BBT
 support
Message-ID: <1385792284-22286-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for On Flash Bad Block Table for PCM-038
onboard NAND.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index 56960c7..fec2d29 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -178,6 +178,7 @@
 &nfc {
 	nand-bus-width = <8>;
 	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
 	status = "okay";
 };
 
-- 
1.8.3.2
