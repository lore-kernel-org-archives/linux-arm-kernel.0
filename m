From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 08:25:32 -0300
Subject: [PATCH v3 07/12] ARM: mvebu: Use the preprocessor on Armada 370/XP
 device tree files
In-Reply-To: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1371554737-25319-8-git-send-email-ezequiel.garcia@free-electrons.com>
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
index 2353b1f..231f8b2 100644
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
index 14e36e1..7005f27 100644
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
index 130f839..5c3a1ec 100644
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
index d6cc8bf..9a6ad0e 100644
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
index 3ee63d1..e0c6f60 100644
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
index f4029f0..c80c60e 100644
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
index 488ca5e..3874548 100644
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
index 46b7850..27a0ecf 100644
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
index 1ee8540..3e770db 100644
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
