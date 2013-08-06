From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 6 Aug 2013 12:49:30 -0500
Subject: [PATCHv3 3/9] ARM: OMAP: DTB: Update IRQ data for WKUP_M3
In-Reply-To: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1375811376-49985-4-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vaibhav Bedia <vaibhav.bedia@ti.com>

Allow interrupt for wkup_m3 to be set from DT.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Cc: Benoit Cousson <benoit.cousson@linaro.org>
---
 arch/arm/boot/dts/am33xx.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 38b446b..05353bf 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -491,6 +491,7 @@
 			compatible = "ti,am3353-wkup-m3";
 			reg = <0x44d00000 0x4000	/* M3 UMEM */
 			       0x44d80000 0x2000>;	/* M3 DMEM */
+			interrupts = <78>;
 			ti,hwmods = "wkup_m3";
 		};
 
-- 
1.7.9.5
