From: borneo.antonio@gmail.com (Antonio Borneo)
Date: Mon, 20 Mar 2017 10:57:21 +0100
Subject: [PATCH 4/4] arm64: dts: NS2: Remove nonexistent properties
In-Reply-To: <20170320095721.6724-1-borneo.antonio@gmail.com>
References: <20170320095721.6724-1-borneo.antonio@gmail.com>
Message-ID: <20170320095721.6724-4-borneo.antonio@gmail.com>
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
Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Brijesh Singh <brijeshkumar.singh@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
To: Ray Jui <rjui@broadcom.com>
To: Scott Branden <sbranden@broadcom.com>
To: Jon Mason <jonmason@broadcom.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Cc: linux-spi at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index 5ae08161649e..2fbd3cd40def 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -113,9 +113,7 @@
 		spi-max-frequency = <5000000>;
 		spi-cpha = <1>;
 		spi-cpol = <1>;
-		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
-		pl022,slave-tx-disable = <0>;
 		pl022,com-mode = <0>;
 		pl022,rx-level-trig = <1>;
 		pl022,tx-level-trig = <1>;
@@ -137,9 +135,7 @@
 		at25,page-size = <64>;
 		spi-cpha = <1>;
 		spi-cpol = <1>;
-		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
-		pl022,slave-tx-disable = <0>;
 		pl022,com-mode = <0>;
 		pl022,rx-level-trig = <1>;
 		pl022,tx-level-trig = <1>;
-- 
2.12.0
