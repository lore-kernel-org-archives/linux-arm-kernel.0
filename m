From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  2 Oct 2012 09:13:20 +0100
Subject: [PATCH 07/10] ARM: ux500: Create a new Device Tree include file for
 boards supporting STUIBs
In-Reply-To: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349165603-24401-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a skeleton creation which will be populated with the devices
found on one of ST-Ericsson's (UIB) User Interface Board.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefprev60.dts  |    1 +
 arch/arm/boot/dts/hrefv60plus.dts |    1 +
 arch/arm/boot/dts/stuib.dtsi      |   15 +++++++++++++++
 3 files changed, 17 insertions(+)
 create mode 100644 arch/arm/boot/dts/stuib.dtsi

diff --git a/arch/arm/boot/dts/hrefprev60.dts b/arch/arm/boot/dts/hrefprev60.dts
index 0756f97..e112cce 100644
--- a/arch/arm/boot/dts/hrefprev60.dts
+++ b/arch/arm/boot/dts/hrefprev60.dts
@@ -12,6 +12,7 @@
 /dts-v1/;
 /include/ "dbx5x0.dtsi"
 /include/ "href.dtsi"
+/include/ "stuib.dtsi"
 
 / {
 	model = "ST-Ericsson HREF (pre-v60) platform with Device Tree";
diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 4b867b2..b5fc355 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -12,6 +12,7 @@
 /dts-v1/;
 /include/ "dbx5x0.dtsi"
 /include/ "href.dtsi"
+/include/ "stuib.dtsi"
 
 / {
 	model = "ST-Ericsson HREF (v60+) platform with Device Tree";
diff --git a/arch/arm/boot/dts/stuib.dtsi b/arch/arm/boot/dts/stuib.dtsi
new file mode 100644
index 0000000..64ac327
--- /dev/null
+++ b/arch/arm/boot/dts/stuib.dtsi
@@ -0,0 +1,15 @@
+/*
+ * Copyright 2012 ST-Ericsson AB
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/ {
+	soc-u9500 {
+	};
+};
-- 
1.7.9.5
