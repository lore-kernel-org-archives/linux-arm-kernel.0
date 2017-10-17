From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 17 Oct 2017 11:17:54 +0200
Subject: [PATCHv3 03/12] ARM: dts: imx6-tx6: remove obsolete ipu1 alias
In-Reply-To: <1508231883-12067-1-git-send-email-LW@KARO-electronics.de>
References: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
 <1508231883-12067-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1508231883-12067-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'ipu1' alias is already defined in imx6q.dtsi. There is no need to
redefine it here.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts b/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
index 6b42c44..be9233d 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
@@ -49,7 +49,6 @@
 
 	aliases {
 		display = &lvds0;
-		ipu1 = &ipu2;
 		lvds0 = &lvds0;
 		lvds1 = &lvds1;
 	};
-- 
2.1.4
