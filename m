From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 28 Mar 2014 11:11:37 +0100
Subject: [PATCH trivial 1/3] ARM: dts: Grammar /is uses/ is used/
Message-ID: <1396001499-17638-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-omap at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/am33xx.dtsi |    2 +-
 arch/arm/boot/dts/dra7.dtsi   |    2 +-
 arch/arm/boot/dts/omap4.dtsi  |    2 +-
 arch/arm/boot/dts/omap5.dtsi  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 6d95d3df33c7..70f7f3eb5fb4 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -68,7 +68,7 @@
 	};
 
 	/*
-	 * The soc node represents the soc top level view. It is uses for IPs
+	 * The soc node represents the soc top level view. It is used for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
 	 */
 	soc {
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1fd75aa4639d..c19e90ecf95e 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -75,7 +75,7 @@
 	};
 
 	/*
-	 * The soc node represents the soc top level view. It is uses for IPs
+	 * The soc node represents the soc top level view. It is used for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
 	 */
 	soc {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3f8a6e8ca20..a07ea359ae20 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -67,7 +67,7 @@
 	};
 
 	/*
-	 * The soc node represents the soc top level view. It is uses for IPs
+	 * The soc node represents the soc top level view. It is used for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
 	 */
 	soc {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index a72813a9663e..aa9878c0aaad 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -87,7 +87,7 @@
 	};
 
 	/*
-	 * The soc node represents the soc top level view. It is uses for IPs
+	 * The soc node represents the soc top level view. It is used for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
 	 */
 	soc {
-- 
1.7.9.5
