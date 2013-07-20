From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 20 Jul 2013 11:17:56 +0400
Subject: [PATCH 3/6] ARM: dts: i.MX27: Add label to CPU node
In-Reply-To: <1374304679-27338-1-git-send-email-shc_work@mail.ru>
References: <1374304679-27338-1-git-send-email-shc_work@mail.ru>
Message-ID: <1374304679-27338-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a label to i.MX27 CPU node. This change allows the reuse this node
in the upper levels of the DTS.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 7cf954b..a8e0c7e 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -53,7 +53,7 @@
 		#size-cells = <0>;
 		#address-cells = <1>;
 
-		cpu {
+		cpu: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,arm926ej-s";
 			operating-points = <
-- 
1.8.1.5
