From: denis@eukrea.com (Denis Carikli)
Date: Mon,  6 Jan 2014 17:16:07 +0100
Subject: [PATCHv3][ 1/2] ARM: dts: imx53: Add gpio and input dt includes.
Message-ID: <1389024968-20242-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to permit to use of the includes in the boards dts.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v2->v3:
- Added The Cc
ChangeLog v1->v2:
- New patch to make it possible to fix the gpios and input in the next patch.
---
 arch/arm/boot/dts/imx53.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 175a94c..6407526 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -13,6 +13,8 @@
 #include "skeleton.dtsi"
 #include "imx53-pingrp.h"
 #include <dt-bindings/clock/imx5-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	aliases {
-- 
1.7.9.5
