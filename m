From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 20 Aug 2016 11:54:20 +0200
Subject: [PATCH v5 2/6] ARM64: dts: amlogic: add the input pin for the IR
 remote
In-Reply-To: <20160820095424.636-1-martin.blumenstingl@googlemail.com>
References: <20160819215547.20063-1-martin.blumenstingl@googlemail.com>
 <20160820095424.636-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160820095424.636-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 4f42316..96f4574 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -210,6 +210,13 @@
 						function = "uart_ao";
 					};
 				};
+
+				remote_input_ao_pins: remote_input_ao {
+					mux {
+						groups = "remote_input_ao";
+						function = "remote_input_ao";
+					};
+				};
 			};
 
 			uart_AO: serial at 4c0 {
-- 
2.9.3
