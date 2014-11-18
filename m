From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Nov 2014 12:07:05 -0600
Subject: [PATCH 07/10] arm: boot: dts: am437x-sk: switch over to new
 edt-ft5306 compatible
In-Reply-To: <1416334028-7766-1-git-send-email-balbi@ti.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
Message-ID: <1416334028-7766-7-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

now that we have the new vendor-less edt-ft5306
i2c_device_id, we can use it

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 859ff3d..26133cb 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -404,7 +404,7 @@
 
 	edt-ft5306 at 38 {
 		status = "okay";
-		compatible = "edt,edt-ft5306", "edt,edt-ft5x06";
+		compatible = "edt-ft5306", "edt-ft5x06";
 		pinctrl-names = "default";
 		pinctrl-0 = <&edt_ft5306_ts_pins>;
 
-- 
2.1.0.GIT
