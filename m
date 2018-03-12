From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 12 Mar 2018 12:23:54 +0800
Subject: [PATCH 2/4] ARM: dts: sun8i: a33: Drop sunxi-common-regulators.dtsi
 for A33-OLinuXino
In-Reply-To: <20180312042356.18625-1-wens@csie.org>
References: <20180312042356.18625-1-wens@csie.org>
Message-ID: <20180312042356.18625-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

None of the common regulators defined in sunxi-common-regulators.dtsi
are used for the A33-OLinuXino.

Drop the include.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index 6349e0bec9a3..925a5339711f 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -43,7 +43,6 @@
 
 /dts-v1/;
 #include "sun8i-a33.dtsi"
-#include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-- 
2.16.2
