From: juri.lelli@arm.com (Juri Lelli)
Date: Mon, 17 Oct 2016 16:46:48 +0100
Subject: [PATCH v7 REPOST 7/9] arm64,
 dts: add Juno r2 cpu capacity-dmips-mhz information
In-Reply-To: <20161017154650.18779-1-juri.lelli@arm.com>
References: <20161017154650.18779-1-juri.lelli@arm.com>
Message-ID: <20161017154650.18779-8-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Juno r2 cpu capacity-dmips-mhz information.

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
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---

Changes from v4:
  - new patch since Juno r2 dt has been merged

Changes from v6:
  - s/bindings// in changelog
---
 arch/arm64/boot/dts/arm/juno-r2.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index 007be826efce..614fc9227943 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -90,6 +90,7 @@
 			next-level-cache = <&A72_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		A72_1: cpu at 1 {
@@ -100,6 +101,7 @@
 			next-level-cache = <&A72_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		A53_0: cpu at 100 {
@@ -110,6 +112,7 @@
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			capacity-dmips-mhz = <485>;
 		};
 
 		A53_1: cpu at 101 {
@@ -120,6 +123,7 @@
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			capacity-dmips-mhz = <485>;
 		};
 
 		A53_2: cpu at 102 {
@@ -130,6 +134,7 @@
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			capacity-dmips-mhz = <485>;
 		};
 
 		A53_3: cpu at 103 {
@@ -140,6 +145,7 @@
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			capacity-dmips-mhz = <485>;
 		};
 
 		A72_L2: l2-cache0 {
-- 
2.10.0
