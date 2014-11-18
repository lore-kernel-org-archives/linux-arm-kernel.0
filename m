From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Nov 2014 12:07:06 -0600
Subject: [PATCH 08/10] arm: boot: dts: imx28-tx28: switch over to new
 edt-ft5x06 compatible
In-Reply-To: <1416334028-7766-1-git-send-email-balbi@ti.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
Message-ID: <1416334028-7766-8-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

now that we have the new vendor-less edt-ft5x06
i2c_device_id, we can use it

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/imx28-tx28.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index a5b27c8..5c5c988 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -319,7 +319,7 @@
 	};
 
 	polytouch: edt-ft5x06 at 38 {
-		compatible = "edt,edt-ft5x06";
+		compatible = "edt-ft5x06";
 		reg = <0x38>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tx28_edt_ft5x06_pins>;
-- 
2.1.0.GIT
