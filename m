From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 6 Aug 2012 19:16:31 +0530
Subject: [PATCH v4 2/2] arm/dts: omap4: Add ocp2scp data
In-Reply-To: <1344260791-6402-1-git-send-email-kishon@ti.com>
References: <1344260791-6402-1-git-send-email-kishon@ti.com>
Message-ID: <1344260791-6402-3-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ocp2scp data node in omap4 device tree file.

Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 04cbbcb..8a780b2 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -295,5 +295,13 @@
 			interrupt-parent = <&gic>;
 			ti,hwmods = "dmic";
 		};
+
+		ocp2scp {
+			compatible = "ti,omap-ocp2scp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			ti,hwmods = "ocp2scp_usb_phy";
+		};
 	};
 };
-- 
1.7.9.5
