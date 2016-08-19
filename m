From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 19 Aug 2016 23:55:43 +0200
Subject: [PATCH v4 2/6] ARM64: dts: amlogic: add the pin for the IR remote
In-Reply-To: <20160819215547.20063-1-martin.blumenstingl@googlemail.com>
References: <20160628191802.21227-1-martin.blumenstingl@googlemail.com>
 <20160819215547.20063-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160819215547.20063-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 4f42316..72df302 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -210,6 +210,13 @@
 						function = "uart_ao";
 					};
 				};
+
+				ir_in_ao_pins: ir_in_ao {
+					mux {
+						groups = "ir_in_ao";
+						function = "ir_in_ao";
+					};
+				};
 			};
 
 			uart_AO: serial at 4c0 {
-- 
2.9.3
