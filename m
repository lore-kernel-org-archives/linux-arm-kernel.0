From: denis@eukrea.com (Denis Carikli)
Date: Thu,  5 Dec 2013 14:28:05 +0100
Subject: [PATCH 2/3] ARM: dts: mxs: Add a new pin config for the usb0 ID.
In-Reply-To: <1386250086-4666-1-git-send-email-denis@eukrea.com>
References: <1386250086-4666-1-git-send-email-denis@eukrea.com>
Message-ID: <1386250086-4666-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx28.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 93a7e79..8d39c42 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -822,6 +822,17 @@
 					fsl,voltage = <MXS_VOLTAGE_HIGH>;
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
+
+				usb0_id_pins_b: usb0id1 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_PWM2__USB0_ID
+					>;
+					fsl,drive-strength = <MXS_DRIVE_12mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_ENABLE>;
+				};
+
 			};
 
 			digctl: digctl at 8001c000 {
-- 
1.7.9.5
