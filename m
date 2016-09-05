From: juri.lelli@arm.com (Juri Lelli)
Date: Mon,  5 Sep 2016 15:22:47 +0100
Subject: [PATCH v7 3/8] arm, dts: add TC2 cpu capacity-dmips-mhz information
In-Reply-To: <1473085372-2840-1-git-send-email-juri.lelli@arm.com>
References: <1473085372-2840-1-git-send-email-juri.lelli@arm.com>
Message-ID: <1473085372-2840-4-git-send-email-juri.lelli@arm.com>
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
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
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
2.7.0
