From: denis@eukrea.com (Denis Carikli)
Date: Fri,  6 Dec 2013 10:59:17 +0100
Subject: [PATCHv2][ 1/2] ARM: dts: imx53: Add gpio and input dt includes.
Message-ID: <1386323958-783-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to permit to use of the includes in the boards dts.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v1->v2:
- New patch to make it possible to fix the gpios and input in the next patch.
---
 arch/arm/boot/dts/imx53.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 885dbbd..891081e 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -14,6 +14,8 @@
 #include "imx53-pinfunc.h"
 #include "imx53-pingrp.h"
 #include <dt-bindings/clock/imx5-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	aliases {
-- 
1.7.9.5
