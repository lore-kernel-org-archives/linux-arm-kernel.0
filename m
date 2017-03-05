From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon,  6 Mar 2017 07:31:34 +0800
Subject: [PATCH v7 2/6] ARM: dts: sun8i: drop pinctrl-a10.h inclusion for H3
 DTSI
In-Reply-To: <20170305233138.64574-1-icenowy@aosc.xyz>
References: <20170305233138.64574-1-icenowy@aosc.xyz>
Message-ID: <20170305233138.64574-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After converting to generic pinconf binding, pinctrl-a10.h is now not
used at all.

Drop its inclusion for H3 DTSI.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
New patch extracted in v7.

 arch/arm/boot/dts/sun8i-h3.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 9a3435527fde..b250e6d03b57 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -42,7 +42,6 @@
 
 #include <dt-bindings/clock/sun8i-h3-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 #include <dt-bindings/reset/sun8i-h3-ccu.h>
 
 / {
-- 
2.11.1
