From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 May 2013 09:17:56 +0800
Subject: [PATCH 1/2] ARM: dts: imx6qdl: remove redundant usbmisc label
Message-ID: <1368407877-12171-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a redundant label on usbmisc node.  Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fd7cc6d..92169e6 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -640,7 +640,7 @@
 				status = "disabled";
 			};
 
-			usbmisc: usbmisc: usbmisc at 02184800 {
+			usbmisc: usbmisc at 02184800 {
 				#index-cells = <1>;
 				compatible = "fsl,imx6q-usbmisc";
 				reg = <0x02184800 0x200>;
-- 
1.7.9.5
