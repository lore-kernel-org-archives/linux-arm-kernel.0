From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 13 Apr 2014 11:48:41 -0300
Subject: [PATCH v4 1/3] ARM: dts: imx27-pdk: Keep the dt nodes sorted
Message-ID: <1397400523-4330-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

For better readability keep the dt nodes sorted.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v3:
- None
Changes since v2:
- None
Changes since v1:
- Newly introduced

 arch/arm/boot/dts/imx27-pdk.dts | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 28c83bc..bd95265 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -21,11 +21,12 @@
 	};
 };
 
-&uart1 {
-	fsl,uart-has-rtscts;
+
+&fec {
 	status = "okay";
 };
 
-&fec {
+&uart1 {
+	fsl,uart-has-rtscts;
 	status = "okay";
 };
-- 
1.8.3.2
