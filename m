From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Sun, 23 Dec 2012 11:34:34 +0900
Subject: [PATCH 1/4] ARM: Kirkwood: Add pinctrl of TWSI1 to 88f6282
Message-ID: <1356230077-15340-1-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 88f6282 has one more TWSI(TWSI1). This add the information to enable
pinctl of TWSI1.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/boot/dts/kirkwood-6282.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 9ae2004..bc23081 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -21,6 +21,12 @@
 				marvell,pins = "mpp8", "mpp9";
 				marvell,function = "twsi0";
 			};
+
+			pmx_twsi1: pmx-twsi1 {
+				marvell,pins = "mpp36", "mpp37";
+				marvell,function = "twsi1";
+			};
+
 			pmx_uart0: pmx-uart0 {
 				marvell,pins = "mpp10", "mpp11";
 				marvell,function = "uart0";
-- 
1.7.10.4
