From: joelf@ti.com (Joel Fernandes)
Date: Thu, 13 Mar 2014 15:35:15 -0500
Subject: [RFC 1/5] ARM: dts: am33xx: Add clock nodes for timer1 and timer2
In-Reply-To: <1394742919-32163-1-git-send-email-joelf@ti.com>
References: <1394742919-32163-1-git-send-email-joelf@ti.com>
Message-ID: <1394742919-32163-2-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 6d95d3d..4e6c959 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -347,6 +347,7 @@
 
 		timer1: timer at 44e31000 {
 			compatible = "ti,am335x-timer-1ms";
+			clocks = <&timer1_fck>;
 			reg = <0x44e31000 0x400>;
 			interrupts = <67>;
 			ti,hwmods = "timer1";
@@ -355,6 +356,7 @@
 
 		timer2: timer at 48040000 {
 			compatible = "ti,am335x-timer";
+			clocks = <&timer2_fck>;
 			reg = <0x48040000 0x400>;
 			interrupts = <68>;
 			ti,hwmods = "timer2";
-- 
1.7.9.5
