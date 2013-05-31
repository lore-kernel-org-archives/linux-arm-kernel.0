From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Fri, 31 May 2013 14:42:19 +0200
Subject: [PATCH 1/4] ARM: dts: AM3XXX: Use #include for all device trees
In-Reply-To: <1370004142-30506-1-git-send-email-florian.vaussard@epfl.ch>
References: <1370004142-30506-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1370004142-30506-2-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace /include/ by #include for AM33XX and AM35XX device tree
files, in order to use the C pre-processor, making use of #define
features possible.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/am335x-bone.dts       |    2 +-
 arch/arm/boot/dts/am335x-evm.dts        |    2 +-
 arch/arm/boot/dts/am335x-evmsk.dts      |    2 +-
 arch/arm/boot/dts/am33xx.dtsi           |    2 +-
 arch/arm/boot/dts/am3517-evm.dts        |    2 +-
 arch/arm/boot/dts/am3517_mt_ventoux.dts |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 74bfcc6..0365e56 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "am33xx.dtsi"
+#include "am33xx.dtsi"
 
 / {
 	model = "TI AM335x BeagleBone";
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 896d392..629476e 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "am33xx.dtsi"
+#include "am33xx.dtsi"
 
 / {
 	model = "TI AM335x EVM";
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 4d81dbc..a339a76 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -13,7 +13,7 @@
 
 /dts-v1/;
 
-/include/ "am33xx.dtsi"
+#include "am33xx.dtsi"
 
 / {
 	model = "TI AM335x EVM-SK";
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index a3daebb..016c460 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -8,7 +8,7 @@
  * kind, whether express or implied.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "ti,am33xx";
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index e9b5bda..e99dfaf 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap34xx.dtsi"
+#include "omap34xx.dtsi"
 
 / {
 	model = "TI AM3517 EVM (AM3517/05)";
diff --git a/arch/arm/boot/dts/am3517_mt_ventoux.dts b/arch/arm/boot/dts/am3517_mt_ventoux.dts
index 5568683..fdf5ce6 100644
--- a/arch/arm/boot/dts/am3517_mt_ventoux.dts
+++ b/arch/arm/boot/dts/am3517_mt_ventoux.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap34xx.dtsi"
+#include "omap34xx.dtsi"
 
 / {
 	model = "TeeJet Mt.Ventoux";
-- 
1.7.5.4
