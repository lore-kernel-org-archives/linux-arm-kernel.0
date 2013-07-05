From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Jul 2013 18:39:28 -0300
Subject: [PATCH v6 17/21] ARM: mvebu: Use the preprocessor on Armada 370/XP
 device tree files
In-Reply-To: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373060372-32357-18-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts              | 2 +-
 arch/arm/boot/dts/armada-370-mirabox.dts         | 2 +-
 arch/arm/boot/dts/armada-370-rd.dts              | 2 +-
 arch/arm/boot/dts/armada-370.dtsi                | 2 +-
 arch/arm/boot/dts/armada-xp-db.dts               | 2 +-
 arch/arm/boot/dts/armada-xp-gp.dts               | 2 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi         | 2 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi         | 2 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 2 +-
 arch/arm/boot/dts/armada-xp.dtsi                 | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index beee169..55b986c 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -14,7 +14,7 @@
  */
 
 /dts-v1/;
-/include/ "armada-370.dtsi"
+#include "armada-370.dtsi"
 
 / {
 	model = "Marvell Armada 370 Evaluation Board";
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 45b1077..37530af 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "armada-370.dtsi"
+#include "armada-370.dtsi"
 
 / {
 	model = "Globalscale Mirabox";
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index a3a2fed..7aa2171 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -12,7 +12,7 @@
  */
 
 /dts-v1/;
-/include/ "armada-370.dtsi"
+#include "armada-370.dtsi"
 
 / {
 	model = "Marvell Armada 370 Reference Design";
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index fa3dfc6..08ec6e3 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -15,7 +15,7 @@
  * common to all Armada SoCs.
  */
 
-/include/ "armada-370-xp.dtsi"
+#include "armada-370-xp.dtsi"
 /include/ "skeleton.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index e28e68f..a9bd766 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -14,7 +14,7 @@
  */
 
 /dts-v1/;
-/include/ "armada-xp-mv78460.dtsi"
+#include "armada-xp-mv78460.dtsi"
 
 / {
 	model = "Marvell Armada XP Evaluation Board";
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index c87b2de..54843e5 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -14,7 +14,7 @@
  */
 
 /dts-v1/;
-/include/ "armada-xp-mv78460.dtsi"
+#include "armada-xp-mv78460.dtsi"
 
 / {
 	model = "Marvell Armada XP Development Board DB-MV784MP-GP";
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 2d9335d..985373a 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -13,7 +13,7 @@
  * common to all Armada XP SoCs.
  */
 
-/include/ "armada-xp.dtsi"
+#include "armada-xp.dtsi"
 
 / {
 	model = "Marvell Armada XP MV78260 SoC";
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index c7b1f4d..f8bf25a 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -13,7 +13,7 @@
  * common to all Armada XP SoCs.
  */
 
-/include/ "armada-xp.dtsi"
+#include "armada-xp.dtsi"
 
 / {
 	model = "Marvell Armada XP MV78460 SoC";
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 8f51045..d090264 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "armada-xp-mv78260.dtsi"
+#include "armada-xp-mv78260.dtsi"
 
 / {
 	model = "PlatHome OpenBlocks AX3-4 board";
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 416eb94..8c07bfe 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -16,7 +16,7 @@
  * common to all Armada SoCs.
  */
 
-/include/ "armada-370-xp.dtsi"
+#include "armada-370-xp.dtsi"
 
 / {
 	model = "Marvell Armada XP family SoC";
-- 
1.8.1.5
