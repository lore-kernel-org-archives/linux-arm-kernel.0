From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 22 Jun 2012 18:45:42 +0530
Subject: [RFC PATCH v2 2/2] arm/dts: omap4: Add ocp2scp data
In-Reply-To: <1340370942-23201-1-git-send-email-kishon@ti.com>
References: <1340370942-23201-1-git-send-email-kishon@ti.com>
Message-ID: <1340370942-23201-3-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ocp2scp data node in omap4 device tree file.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d2cb392..9082191 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -285,5 +285,12 @@
 				compatible = "ti,omap4-usb-phy";
 			};
 		};
+
+		ocp2scp at 4a0ad000  {
+			compatible = "ti,omap-ocp2scp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ti,hwmods = "ocp2scp_usb_phy";
+		};
 	};
 };
-- 
1.7.5.4
