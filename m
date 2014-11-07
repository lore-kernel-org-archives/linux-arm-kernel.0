From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Fri, 7 Nov 2014 15:05:43 -0600
Subject: [PATCH] arm: dts: socfpga: enable watchdog for socfpga platform
Message-ID: <1415394343-2811-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_cyclone5.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index 28c05e7..06db951 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -49,3 +49,7 @@
 		};
 	};
 };
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.0.3
