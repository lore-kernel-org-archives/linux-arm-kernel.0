From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 2 Nov 2016 09:32:58 -0500
Subject: [PATCHv3 4/4] ARM: socfpga: dts: Add Monitor to A10-SR MFD
In-Reply-To: <1478097178-24341-1-git-send-email-tthayer@opensource.altera.com>
References: <1478097178-24341-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1478097178-24341-5-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the Monitor functionality to the Arria10 DevKit
System Resource chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  Change from -mon to -monitor for clarity.
v3  Change node name from a10_monitor to monitor.
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index eb00ae3..996e745 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -121,6 +121,10 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
+
+		monitor {
+			compatible = "altr,a10sr-monitor";
+		};
 	};
 };
 
-- 
1.9.1
