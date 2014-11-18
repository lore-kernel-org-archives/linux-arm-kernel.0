From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Nov 2014 12:07:08 -0600
Subject: [PATCH 10/10] arm: boot: dts: imx6qdl-tx6: switch over to new
 edt-ft5x06 compatible
In-Reply-To: <1416334028-7766-1-git-send-email-balbi@ti.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
Message-ID: <1416334028-7766-10-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

now that we have the new vendor-less edt-ft5x06
i2c_device_id, we can use it

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index f02b80b..5ecf3bf 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -267,7 +267,7 @@
 	};
 
 	polytouch: edt-ft5x06 at 38 {
-		compatible = "edt,edt-ft5x06";
+		compatible = "edt-ft5x06";
 		reg = <0x38>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_edt_ft5x06>;
-- 
2.1.0.GIT
