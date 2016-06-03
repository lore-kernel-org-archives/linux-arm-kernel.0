From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  3 Jun 2016 10:47:01 +0200
Subject: [PATCH 3/3] ARM64: dts: meson-gxbb: Add Hardware Random Generator node
In-Reply-To: <1464943621-18278-1-git-send-email-narmstrong@baylibre.com>
References: <1464943621-18278-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1464943621-18278-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 832815d..8353621 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -167,6 +167,11 @@
 			};
 		};
 
+		rng {
+			compatible = "amlogic,meson-rng";
+			reg = <0x0 0xc8834000 0x0 0x4>;
+		};
+
 		apb: apb at d0000000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xd0000000 0x0 0x200000>;
-- 
2.7.0
