From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 28 Jun 2018 10:13:36 +0300
Subject: [PATCH 2/2] ARM: dts: armada388-clearfog: drop future changes
 disclaimer
In-Reply-To: <2bc87e3e365c460943730ded86c8fcb1ff55a533.1530170016.git.baruch@tkos.co.il>
References: <2bc87e3e365c460943730ded86c8fcb1ff55a533.1530170016.git.baruch@tkos.co.il>
Message-ID: <2c2eb16ffa18023d8d1be759ad8dc7e6c5affc5d.1530170016.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current device-tree description of the SolidRun Armada 38x platforms
has been successfully tested with production systems.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/armada-388-clearfog-base.dts      | 5 -----
 arch/arm/boot/dts/armada-388-clearfog-pro.dts       | 5 -----
 arch/arm/boot/dts/armada-388-clearfog.dts           | 5 -----
 arch/arm/boot/dts/armada-388-clearfog.dtsi          | 5 -----
 arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 5 -----
 5 files changed, 25 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog-base.dts b/arch/arm/boot/dts/armada-388-clearfog-base.dts
index 50ed4ae5c621..53b4bd35522a 100644
--- a/arch/arm/boot/dts/armada-388-clearfog-base.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog-base.dts
@@ -3,11 +3,6 @@
  * Device Tree file for SolidRun Clearfog Base revision A1 rev 2.0 (88F6828)
  *
  *  Copyright (C) 2015 Russell King
- *
- * This board is in development; the contents of this file work with
- * the A1 rev 2.0 of the board, which does not represent final
- * production board.  Things will change, don't expect this file to
- * remain compatible info the future.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/armada-388-clearfog-pro.dts b/arch/arm/boot/dts/armada-388-clearfog-pro.dts
index 24e4b5a509be..ff890c09c3ed 100644
--- a/arch/arm/boot/dts/armada-388-clearfog-pro.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog-pro.dts
@@ -3,11 +3,6 @@
  * Device Tree file for SolidRun Clearfog Pro revision A1 rev 2.0 (88F6828)
  *
  *  Copyright (C) 2015 Russell King
- *
- * This board is in development; the contents of this file work with
- * the A1 rev 2.0 of the board, which does not represent final
- * production board.  Things will change, don't expect this file to
- * remain compatible info the future.
  */
 #include "armada-388-clearfog.dts"
 
diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index 5fd0f6f61e77..32b1e09b8293 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -3,11 +3,6 @@
  * Device Tree file for SolidRun Clearfog Pro revision A1 rev 2.0 (88F6828)
  *
  *  Copyright (C) 2015 Russell King
- *
- * This board is in development; the contents of this file work with
- * the A1 rev 2.0 of the board, which does not represent final
- * production board.  Things will change, don't expect this file to
- * remain compatible info the future.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
index 0d9dfdfe977e..1da40bdfcef1 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
+++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
@@ -3,11 +3,6 @@
  * Device Tree include file for SolidRun Clearfog 88F6828 based boards
  *
  *  Copyright (C) 2015 Russell King
- *
- * This board is in development; the contents of this file work with
- * the A1 rev 2.0 of the board, which does not represent final
- * production board.  Things will change, don't expect this file to
- * remain compatible info the future.
  */
 
 #include "armada-388.dtsi"
diff --git a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
index c990d502d9a4..3a7f9c1ac346 100644
--- a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
+++ b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
@@ -3,11 +3,6 @@
  * Device Tree file for SolidRun Armada 38x Microsom
  *
  *  Copyright (C) 2015 Russell King
- *
- * This board is in development; the contents of this file work with
- * the A1 rev 2.0 of the board, which does not represent final
- * production board.  Things will change, don't expect this file to
- * remain compatible info the future.
  */
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
-- 
2.18.0
