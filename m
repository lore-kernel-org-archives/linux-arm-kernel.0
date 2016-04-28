From: j-keerthy@ti.com (Keerthy)
Date: Thu, 28 Apr 2016 15:35:49 +0530
Subject: [PATCH RESEND 4/4] ARM: dts: am57xx-idk: Include Industrial grade
 thermal thresholds
In-Reply-To: <1461837949-11116-1-git-send-email-j-keerthy@ti.com>
References: <1461837949-11116-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1461837949-11116-5-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

am57xx-idk have Industrial grade samples whose thermal
thresholds are different as compared with dra7. Hence correcting the same.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 2805b68..b01a594 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -6,6 +6,8 @@
  * published by the Free Software Foundation.
  */
 
+#include "am57xx-industrial-grade.dtsi"
+
 / {
 	aliases {
 		rtc0 = &tps659038_rtc;
-- 
1.9.1
