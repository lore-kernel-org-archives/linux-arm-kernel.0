From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 3 Jan 2013 14:47:22 -0200
Subject: [PATCH] ARM: dts: imx31-bug: Fix manufacturer compatible string
Message-ID: <1357231642-12857-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the compatible field we should point the manufacturer of the board, which
in this case is Buglabs.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx31-bug.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx31-bug.dts b/arch/arm/boot/dts/imx31-bug.dts
index e0bcdde..9ac6f6b 100644
--- a/arch/arm/boot/dts/imx31-bug.dts
+++ b/arch/arm/boot/dts/imx31-bug.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "Buglabs i.MX31 Bug 1.x";
-	compatible = "fsl,imx31-bug", "fsl,imx31";
+	compatible = "buglabs,imx31-bug", "fsl,imx31";
 
 	memory {
 		reg = <0x80000000 0x8000000>; /* 128M */
-- 
1.7.9.5
