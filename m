From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 Dec 2016 16:16:01 +0530
Subject: [PATCH v2 2/3] ARM: EXYNOS: dts: add enable-method property for cpus
 node
In-Reply-To: <1481366762-26413-1-git-send-email-pankaj.dubey@samsung.com>
References: <1481366762-26413-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1481366762-26413-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the enable-method property for the cpu node on various exynosMMMM.dtsi.
This is used for CPU_METHOD_OF_DECLARE to use to enable the secondary core.

CC: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi      | 1 +
 arch/arm/boot/dts/exynos4210.dtsi      | 1 +
 arch/arm/boot/dts/exynos4212.dtsi      | 1 +
 arch/arm/boot/dts/exynos4412.dtsi      | 1 +
 arch/arm/boot/dts/exynos5250.dtsi      | 1 +
 arch/arm/boot/dts/exynos5260.dtsi      | 1 +
 arch/arm/boot/dts/exynos5410.dtsi      | 1 +
 arch/arm/boot/dts/exynos5420-cpus.dtsi | 1 +
 arch/arm/boot/dts/exynos5422-cpus.dtsi | 1 +
 arch/arm/boot/dts/exynos5440.dtsi      | 1 +
 10 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index ba17ee1..f28f669 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -53,6 +53,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 7f3a18c..6dfd98d 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -35,6 +35,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at 900 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 5389011..3e8982e 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -25,6 +25,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at A00 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 40beede..faf2fb8 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -25,6 +25,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at A00 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index b6d7444..580897c 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -52,6 +52,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 5818718..1af6e76 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -32,6 +32,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 2b6adaf..b092cdc 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -33,6 +33,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
index 5c052d7..a587704 100644
--- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
@@ -24,6 +24,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index bf3c6f1..7fcdfd0 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -23,6 +23,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at 100 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 2a2e570..0a958e8 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -50,6 +50,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu at 0 {
 			device_type = "cpu";
-- 
2.7.4
