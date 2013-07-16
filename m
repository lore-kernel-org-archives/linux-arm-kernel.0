From: nm@ti.com (Nishanth Menon)
Date: Tue, 16 Jul 2013 09:23:54 -0500
Subject: [PATCH 2/2] regulator: palmas-pmic: doc: remove ti,tstep
In-Reply-To: <1373984635-14958-1-git-send-email-nm@ti.com>
References: <1373984635-14958-1-git-send-email-nm@ti.com>
Message-ID: <1373984635-14958-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 28d1e8cd671a53d6b4f967abbbc2a55f7bd333f6
(regulator: palma: add ramp delay support through regulator constraints)

Removed the regulator's ti,step option from driver without updating the
documentation. remove the support from documentation and example as well.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../devicetree/bindings/regulator/palmas-pmic.txt  |    2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/palmas-pmic.txt b/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
index 04d67f0..30b0581 100644
--- a/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
+++ b/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
@@ -33,7 +33,6 @@ Optional nodes:
 	       ti,roof-floor - control voltage selection by pin(boolean)
 	       ti,mode-sleep - mode to adopt in pmic sleep 0 - off, 1 - auto,
 	       2 - eco, 3 - forced pwm
-	       ti,tstep - slope control 0 - Jump, 1 10mV/us, 2 5mV/us, 3 2.5mV/us
 	       ti,smps-range - OTP has the wrong range set for the hardware so override
 	       0 - low range, 1 - high range.
 
@@ -59,7 +58,6 @@ pmic {
 			ti,warm-reset;
 			ti,roof-floor;
 			ti,mode-sleep = <0>;
-			ti,tstep = <0>;
 			ti,smps-range = <1>;
 		};
 
-- 
1.7.9.5
