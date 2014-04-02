From: syin@broadcom.com (Sherman Yin)
Date: Wed, 2 Apr 2014 15:40:39 -0700
Subject: [PATCH v3 3/3] pinctrl: fix typo in bindings documentation
In-Reply-To: <1396478439-16586-1-git-send-email-syin@broadcom.com>
References: <1390509887-19278-1-git-send-email-syin@broadcom.com>
 <1396478439-16586-1-git-send-email-syin@broadcom.com>
Message-ID: <1396478439-16586-4-git-send-email-syin@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed the missing comma in DT node example.

Signed-off-by: Sherman Yin <syin@broadcom.com>
---
 .../bindings/pinctrl/brcm,bcm11351-pinctrl.txt     |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
index c119deb..67a5db9 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
@@ -119,7 +119,7 @@ Optional Properties (for HDMI pins):
 Example:
 // pin controller node
 pinctrl at 35004800 {
-	compatible = "brcmbcm11351-pinctrl";
+	compatible = "brcm,bcm11351-pinctrl";
 	reg = <0x35004800 0x430>;
 
 	// pin configuration node
-- 
1.7.9.5
