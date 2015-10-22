From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 22 Oct 2015 11:19:10 +0200
Subject: [PATCH 1/4] arm: dts: add dm816x missing #mbox-cells
Message-ID: <5628AA0E.1080205@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing #mbox-cells for dm816x mbox DT node.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 3c99cfa..a7a34e4 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -218,6 +218,7 @@
 			reg = <0x480c8000 0x2000>;
 			interrupts = <77>;
 			ti,hwmods = "mailbox";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			mbox_dsp: mbox_dsp {
-- 
1.9.1
