From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon,  7 Mar 2016 19:24:15 +0100
Subject: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys example
Message-ID: <1457375055-5544-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop #address-cells and #size-cells, which are not required by the
gpio-keys binding documentation, as button sub-nodes are not devices.

Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/input/gpio-keys.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index 21641236c095..1552a11f6786 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -34,8 +34,6 @@ Example nodes:
 
 	gpio_keys {
 			compatible = "gpio-keys";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			autorepeat;
 			button at 21 {
 				label = "GPIO Key UP";
-- 
2.6.2
