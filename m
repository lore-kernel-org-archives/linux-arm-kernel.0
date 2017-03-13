From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 13 Mar 2017 10:10:51 +0100
Subject: [RESEND PATCH 2/3] ARM64: dts: meson-gx: empty line cleanup
In-Reply-To: <1489396252-28696-1-git-send-email-narmstrong@baylibre.com>
References: <1489396252-28696-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1489396252-28696-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 2d8dc6f..06d70bf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -410,7 +410,6 @@
 			};
 		};
 
-
 		hiubus: hiubus at c883c000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc883c000 0x0 0x2000>;
-- 
1.9.1
