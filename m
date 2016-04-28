From: j-keerthy@ti.com (Keerthy)
Date: Thu, 28 Apr 2016 15:35:48 +0530
Subject: [PATCH RESEND 3/4] ARM: dts: am57xx-beagle-x15: Include the
 commercial grade thresholds
In-Reply-To: <1461837949-11116-1-git-send-email-j-keerthy@ti.com>
References: <1461837949-11116-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1461837949-11116-4-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

am57xx-beagle-x15 have commercial grade samples whose
thermal thresholds lower than dra7. Hence correcting the same.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index f0a0efb..f6904f6 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "dra74x.dtsi"
+#include "am57xx-commercial-grade.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
-- 
1.9.1
