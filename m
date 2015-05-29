From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 29 May 2015 16:33:02 +0200
Subject: [PATCH 1/2] ARM: socfpga: socrates: enable gpio0/1
Message-ID: <1432909983-19821-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the gpio0+1 controller.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
index a1814b457450..a81f33deaa3a 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
@@ -36,6 +36,14 @@
 	status = "okay";
 };
 
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.1.4
