From: joel@jms.id.au (Joel Stanley)
Date: Fri, 15 Dec 2017 16:54:35 +1030
Subject: [PATCH v2 11/19] ARM: dts: aspeed: Remove skeleton.dtsi
In-Reply-To: <20171215062443.23059-1-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
Message-ID: <20171215062443.23059-12-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't require it for any of the ASPEED systems.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 1 -
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index b3580f37f507..2d7ac577d6b5 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/aspeed-clock.h>
 #include <dt-bindings/gpio/aspeed-gpio.h>
 
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 50766f0629f8..030a760696fd 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/aspeed-clock.h>
 #include <dt-bindings/gpio/aspeed-gpio.h>
 
-- 
2.14.1
