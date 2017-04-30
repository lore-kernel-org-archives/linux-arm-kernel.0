From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 30 Apr 2017 20:30:52 +0200
Subject: [PATCH 1/3] ARM: dts: rockchip: Move cros-ec-sbs to
 rk3288-veyron-chromebook-sbs
Message-ID: <20170430183054.24563-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the cros-ec-sbs dtsi to a new rk3288-veyron-chromebook-sbs
dtsi since it only concerns rk3288 veyron Chromebooks.

Other Chromebooks (such as the tegra124 nyans) also have sbs batteries
and don't use this dtsi, that only makes sense when used with
rk3288-veyron-chromebook anyway.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 .../boot/dts/{cros-ec-sbs.dtsi => rk3288-veyron-chromebook-sbs.dtsi}    | 0
 arch/arm/boot/dts/rk3288-veyron-jaq.dts                                 | 2 +-
 arch/arm/boot/dts/rk3288-veyron-jerry.dts                               | 2 +-
 arch/arm/boot/dts/rk3288-veyron-pinky.dts                               | 2 +-
 arch/arm/boot/dts/rk3288-veyron-speedy.dts                              | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm/boot/dts/{cros-ec-sbs.dtsi => rk3288-veyron-chromebook-sbs.dtsi} (100%)

diff --git a/arch/arm/boot/dts/cros-ec-sbs.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook-sbs.dtsi
similarity index 100%
rename from arch/arm/boot/dts/cros-ec-sbs.dtsi
rename to arch/arm/boot/dts/rk3288-veyron-chromebook-sbs.dtsi
diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index d33f5763c39c..f217a978e47a 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -45,7 +45,7 @@
 /dts-v1/;
 
 #include "rk3288-veyron-chromebook.dtsi"
-#include "cros-ec-sbs.dtsi"
+#include "rk3288-veyron-chromebook-sbs.dtsi"
 
 / {
 	model = "Google Jaq";
diff --git a/arch/arm/boot/dts/rk3288-veyron-jerry.dts b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
index cdea751f2a8c..bec607574165 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
@@ -44,7 +44,7 @@
 
 /dts-v1/;
 #include "rk3288-veyron-chromebook.dtsi"
-#include "cros-ec-sbs.dtsi"
+#include "rk3288-veyron-chromebook-sbs.dtsi"
 
 / {
 	model = "Google Jerry";
diff --git a/arch/arm/boot/dts/rk3288-veyron-pinky.dts b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
index 995cff42fa43..c81ad5bf1121 100644
--- a/arch/arm/boot/dts/rk3288-veyron-pinky.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
@@ -44,7 +44,7 @@
 
 /dts-v1/;
 #include "rk3288-veyron-chromebook.dtsi"
-#include "cros-ec-sbs.dtsi"
+#include "rk3288-veyron-chromebook-sbs.dtsi"
 
 / {
 	model = "Google Pinky";
diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
index cc0b78cefe34..8aea9c3ff6e2 100644
--- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
@@ -44,7 +44,7 @@
 
 /dts-v1/;
 #include "rk3288-veyron-chromebook.dtsi"
-#include "cros-ec-sbs.dtsi"
+#include "rk3288-veyron-chromebook-sbs.dtsi"
 
 / {
 	model = "Google Speedy";
-- 
2.12.2
