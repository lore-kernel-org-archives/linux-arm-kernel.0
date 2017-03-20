From: borneo.antonio@gmail.com (Antonio Borneo)
Date: Mon, 20 Mar 2017 10:57:19 +0100
Subject: [PATCH 2/4] ARM: SPEAr: DT: Remove nonexistent properties
In-Reply-To: <20170320095721.6724-1-borneo.antonio@gmail.com>
References: <20170320095721.6724-1-borneo.antonio@gmail.com>
Message-ID: <20170320095721.6724-2-borneo.antonio@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The properties "pl022,hierarchy" and "pl022,slave-tx-disable" are
not documented in DT binding and don't exist in the driver code.
They have no effect and can be removed.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
To: Viresh Kumar <vireshk@kernel.org>
To: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Brijesh Singh <brijeshkumar.singh@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Cc: linux-spi at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/spear1310-evb.dts | 6 ------
 arch/arm/boot/dts/spear1340-evb.dts | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index 84101e4eebbf..e70f78b7eaf4 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -358,9 +358,7 @@
 					#size-cells = <0>;
 					spi-max-frequency = <1000000>;
 					spi-cpha;
-					pl022,hierarchy = <0>;
 					pl022,interface = <0>;
-					pl022,slave-tx-disable;
 					pl022,com-mode = <0>;
 					pl022,rx-level-trig = <0>;
 					pl022,tx-level-trig = <0>;
@@ -391,9 +389,7 @@
 					spi-max-frequency = <12000000>;
 					spi-cpol;
 					spi-cpha;
-					pl022,hierarchy = <0>;
 					pl022,interface = <0>;
-					pl022,slave-tx-disable;
 					pl022,com-mode = <0x2>;
 					pl022,rx-level-trig = <0>;
 					pl022,tx-level-trig = <0>;
@@ -407,9 +403,7 @@
 					reg = <2>;
 					spi-max-frequency = <25000000>;
 					spi-cpha;
-					pl022,hierarchy = <0>;
 					pl022,interface = <0>;
-					pl022,slave-tx-disable;
 					pl022,com-mode = <0x2>;
 					pl022,rx-level-trig = <0>;
 					pl022,tx-level-trig = <0>;
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index 6565f3cb866f..f31d2e83fae5 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -451,9 +451,7 @@
 					spi-max-frequency = <12000000>;
 					spi-cpol;
 					spi-cpha;
-					pl022,hierarchy = <0>;
 					pl022,interface = <0>;
-					pl022,slave-tx-disable;
 					pl022,com-mode = <0x2>;
 					pl022,rx-level-trig = <0>;
 					pl022,tx-level-trig = <0>;
@@ -467,9 +465,7 @@
 					spi-max-frequency = <1000000>;
 					spi-cpha;
 					reg = <1>;
-					pl022,hierarchy = <0>;
 					pl022,interface = <0>;
-					pl022,slave-tx-disable;
 					pl022,com-mode = <0>;
 					pl022,rx-level-trig = <0>;
 					pl022,tx-level-trig = <0>;
@@ -501,9 +497,7 @@
 					reg = <2>;
 					spi-max-frequency = <25000000>;
 					spi-cpha;
-					pl022,hierarchy = <0>;
 					pl022,interface = <0>;
-					pl022,slave-tx-disable;
 					pl022,com-mode = <0x2>;
 					pl022,rx-level-trig = <0>;
 					pl022,tx-level-trig = <0>;
-- 
2.12.0
