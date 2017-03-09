From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  9 Mar 2017 11:39:07 +0100
Subject: [PATCH 2/3] ARM64: dts: meson-gx: empty line cleanup
In-Reply-To: <1489055948-10656-1-git-send-email-narmstrong@baylibre.com>
References: <1489055948-10656-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1489055948-10656-3-git-send-email-narmstrong@baylibre.com>
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
