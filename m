From: juri.lelli@arm.com (Juri Lelli)
Date: Mon, 23 Nov 2015 14:28:39 +0000
Subject: [RFC PATCH 6/8] arm64, dts: add Juno cpu capacity information
In-Reply-To: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
Message-ID: <1448288921-30307-7-git-send-email-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Juno cpu capacity bindings information.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jon Medhurst <tixy@linaro.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm64/boot/dts/arm/juno.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index d7cbdd4..06f6d2b 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -33,6 +33,7 @@
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
+		capacity-scale = <1024>;
 
 		A57_0: cpu at 0 {
 			compatible = "arm,cortex-a57","arm,armv8";
@@ -40,6 +41,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
+			capacity = <1024>;
 		};
 
 		A57_1: cpu at 1 {
@@ -48,6 +50,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
+			capacity = <1024>;
 		};
 
 		A53_0: cpu at 100 {
@@ -56,6 +59,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			capacity = <447>;
 		};
 
 		A53_1: cpu at 101 {
@@ -64,6 +68,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			capacity = <447>;
 		};
 
 		A53_2: cpu at 102 {
@@ -72,6 +77,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			capacity = <447>;
 		};
 
 		A53_3: cpu at 103 {
@@ -80,6 +86,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			capacity = <447>;
 		};
 
 		A57_L2: l2-cache0 {
-- 
2.2.2
