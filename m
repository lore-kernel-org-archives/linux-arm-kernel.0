From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 13 Oct 2016 16:32:09 -0500
Subject: [PATCH 4/4] ARM: socfpga: dts: Add Monitor to A10-SR MFD
In-Reply-To: <1476394329-31696-1-git-send-email-tthayer@opensource.altera.com>
References: <1476394329-31696-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1476394329-31696-5-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the Monitor functionality to the Arria10 DevKit
System Resource chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index eb00ae3..183d88b 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -121,6 +121,10 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
+
+		a10sr_monitor {
+			compatible = "altr,a10sr-mon";
+		};
 	};
 };
 
-- 
1.7.9.5
