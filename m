From: matt.porter@linaro.org (Matt Porter)
Date: Thu,  6 Jun 2013 01:41:34 -0400
Subject: [PATCH 1/2] ARM: dts: bcm281xx: use #include for device tree files
In-Reply-To: <1370497295-12682-1-git-send-email-matt.porter@linaro.org>
References: <1370497295-12682-1-git-send-email-matt.porter@linaro.org>
Message-ID: <1370497295-12682-2-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace /include/ by #include for bcm281xx device tree
files, enabling use of the C preprocessor.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
---
 arch/arm/boot/dts/bcm11351-brt.dts |    2 +-
 arch/arm/boot/dts/bcm11351.dtsi    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
index 248067c..3392f64 100644
--- a/arch/arm/boot/dts/bcm11351-brt.dts
+++ b/arch/arm/boot/dts/bcm11351-brt.dts
@@ -13,7 +13,7 @@
 
 /dts-v1/;
 
-/include/ "bcm11351.dtsi"
+#include "bcm11351.dtsi"
 
 / {
 	model = "BCM11351 BRT board";
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 41b2c6c..c08810e 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -11,7 +11,7 @@
  * GNU General Public License for more details.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	model = "BCM11351 SoC";
-- 
1.7.9.5
