From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 May 2013 09:17:57 +0800
Subject: [PATCH 2/2] ARM: dts: imx6qdl: remove redundant ocotp node
In-Reply-To: <1368407877-12171-1-git-send-email-shawn.guo@linaro.org>
References: <1368407877-12171-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1368407877-12171-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a redundant ocotp node.  Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 92169e6..42e461c 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -754,11 +754,6 @@
 				reg = <0x021bc000 0x4000>;
 			};
 
-			ocotp at 021c0000 {
-				reg = <0x021c0000 0x4000>;
-				interrupts = <0 21 0x04>;
-			};
-
 			tzasc at 021d0000 { /* TZASC1 */
 				reg = <0x021d0000 0x4000>;
 				interrupts = <0 108 0x04>;
-- 
1.7.9.5
