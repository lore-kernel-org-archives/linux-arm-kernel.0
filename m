From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 7 Jan 2013 10:48:34 +0530
Subject: [PATCH 4/5] ARM: dts: AM33XX: Add am335x-evmsk lcdc panel timings
In-Reply-To: <cover.1357304150.git.afzal@ti.com>
References: <cover.1357304150.git.afzal@ti.com>
Message-ID: <d30d39123012539214a1de2940e522ed205eb5b8.1357304150.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update lcdc node with panel timings (typical) for AM335X-EVMSK.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index f5a6162..a7e017b 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -248,3 +248,23 @@
 		};
 	};
 };
+
+&lcdc {
+	status = "okay";
+
+	display-timings {
+		480x272p57 {
+			clock-frequency = <9000000>;
+			hactive = <480>;
+			vactive = <272>;
+			hfront-porch = <8>;
+			hback-porch = <43>;
+			hsync-len = <4>;
+			vback-porch = <12>;
+			vfront-porch = <4>;
+			vsync-len = <10>;
+			hsync-active = <1>;
+			vsync-active = <1>;
+		};
+	};
+};
-- 
1.7.9.5
