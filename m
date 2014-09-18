From: nm@ti.com (Nishanth Menon)
Date: Thu, 18 Sep 2014 14:04:44 -0500
Subject: [PATCH V3 1/3] Documentation: dt-bindings: mfd: palmas: Fix example
 style of i2c peripheral
In-Reply-To: <1411067086-16613-1-git-send-email-nm@ti.com>
References: <1411067086-16613-1-git-send-email-nm@ti.com>
Message-ID: <1411067086-16613-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use device at address as name for device nodes.

Suggested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
V3: no change
V2: http://marc.info/?l=linux-kernel&m=140995036518562&w=2

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
