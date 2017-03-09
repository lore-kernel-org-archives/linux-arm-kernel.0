From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  9 Mar 2017 15:52:46 +0100
Subject: [PATCH 2/2] ARM64: dts: meson-gxbb-odroidc2: Fix TFLASH VDD regulator
 GPIO line
In-Reply-To: <1489071166-11476-1-git-send-email-narmstrong@baylibre.com>
References: <1489071166-11476-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1489071166-11476-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wrong GPIO line was provided here.

Fixes: ef8d2ffedf18 ("ARM64: dts: meson-gxbb: add MMC support")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index def5aed..a03b9b2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -96,7 +96,7 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
-		gpio = <&gpio_ao GPIOAO_12 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio GPIOY_12 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
-- 
1.9.1
