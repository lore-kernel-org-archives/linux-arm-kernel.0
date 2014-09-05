From: nm@ti.com (Nishanth Menon)
Date: Fri, 5 Sep 2014 15:51:49 -0500
Subject: [PATCH V2 1/3] Documentation: dt-bindings: mfd: palmas: Fix example
 style of i2c peripheral
In-Reply-To: <1409950311-25236-1-git-send-email-nm@ti.com>
References: <1409950311-25236-1-git-send-email-nm@ti.com>
Message-ID: <1409950311-25236-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use device at address as name for device nodes.

Suggested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 Documentation/devicetree/bindings/mfd/palmas.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/palmas.txt b/Documentation/devicetree/bindings/mfd/palmas.txt
index eda8989..d193859 100644
--- a/Documentation/devicetree/bindings/mfd/palmas.txt
+++ b/Documentation/devicetree/bindings/mfd/palmas.txt
@@ -33,7 +33,7 @@ Optional properties:
 
 Example:
 
-palmas {
+palmas at 48 {
 	compatible = "ti,twl6035", "ti,palmas";
 	reg = <0x48>
 	interrupt-parent = <&intc>;
-- 
1.7.9.5
