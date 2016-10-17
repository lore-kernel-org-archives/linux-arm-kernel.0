From: juri.lelli@arm.com (Juri Lelli)
Date: Mon, 17 Oct 2016 16:46:44 +0100
Subject: [PATCH v7 REPOST 3/9] arm,
 dts: add TC2 cpu capacity-dmips-mhz information
In-Reply-To: <20161017154650.18779-1-juri.lelli@arm.com>
References: <20161017154650.18779-1-juri.lelli@arm.com>
Message-ID: <20161017154650.18779-4-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TC2 cpu capacity information.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: devicetree at vger.kernel.org
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---

Changes from v1:
  - capacity-scale removed

Changes from v4:
  - binding changed to capacity-dmips-mhz

Changes from v6:
  - s/binding// in changelog
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 0205c97efdef..45d08cc37b01 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -39,6 +39,7 @@
 			reg = <0>;
 			cci-control-port = <&cci_control1>;
 			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu1: cpu at 1 {
@@ -47,6 +48,7 @@
 			reg = <1>;
 			cci-control-port = <&cci_control1>;
 			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu2: cpu at 2 {
@@ -55,6 +57,7 @@
 			reg = <0x100>;
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
+			capacity-dmips-mhz = <516>;
 		};
 
 		cpu3: cpu at 3 {
@@ -63,6 +66,7 @@
 			reg = <0x101>;
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
+			capacity-dmips-mhz = <516>;
 		};
 
 		cpu4: cpu at 4 {
@@ -71,6 +75,7 @@
 			reg = <0x102>;
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
+			capacity-dmips-mhz = <516>;
 		};
 
 		idle-states {
-- 
2.10.0
