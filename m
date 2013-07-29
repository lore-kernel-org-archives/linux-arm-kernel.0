From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 29 Jul 2013 14:31:50 +0200
Subject: [PATCH 1/5] ARM: dove: use preprocessor on device tree files
In-Reply-To: <1375101114-28858-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1375101114-28858-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1375101114-28858-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This coverts Dove DT board files to preprocessor includes instead
of dtc includes.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove-cm-a510.dts |    2 +-
 arch/arm/boot/dts/dove-cubox.dts   |    2 +-
 arch/arm/boot/dts/dove-d2plug.dts  |    2 +-
 arch/arm/boot/dts/dove-dove-db.dts |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dove-cm-a510.dts b/arch/arm/boot/dts/dove-cm-a510.dts
index 61a8062..50c0d69 100644
--- a/arch/arm/boot/dts/dove-cm-a510.dts
+++ b/arch/arm/boot/dts/dove-cm-a510.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "dove.dtsi"
+#include "dove.dtsi"
 
 / {
 	model = "Compulab CM-A510";
diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 022646e..4af59b6 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "dove.dtsi"
+#include "dove.dtsi"
 
 / {
 	model = "SolidRun CuBox";
diff --git a/arch/arm/boot/dts/dove-d2plug.dts b/arch/arm/boot/dts/dove-d2plug.dts
index e2222ce..c11d363 100644
--- a/arch/arm/boot/dts/dove-d2plug.dts
+++ b/arch/arm/boot/dts/dove-d2plug.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "dove.dtsi"
+#include "dove.dtsi"
 
 / {
 	model = "Globalscale D2Plug";
diff --git a/arch/arm/boot/dts/dove-dove-db.dts b/arch/arm/boot/dts/dove-dove-db.dts
index e5a920b..bb725dc 100644
--- a/arch/arm/boot/dts/dove-dove-db.dts
+++ b/arch/arm/boot/dts/dove-dove-db.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "dove.dtsi"
+#include "dove.dtsi"
 
 / {
 	model = "Marvell DB-MV88AP510-BP Development Board";
-- 
1.7.10.4
