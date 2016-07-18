From: jun.li@nxp.com (Li Jun)
Date: Mon, 18 Jul 2016 19:15:44 +0800
Subject: [PATCH 1/4] doc: usb: usbmisc-imx: add imx7d compatible string
Message-ID: <1468840547-17899-1-git-send-email-jun.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible string for imx7d-usbmisc.

Signed-off-by: Li Jun <jun.li@nxp.com>
---
 Documentation/devicetree/bindings/usb/usbmisc-imx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
index 3539d4e..f1e27fa 100644
--- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
+++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
@@ -6,6 +6,7 @@ Required properties:
 	"fsl,imx6q-usbmisc" for imx6q
 	"fsl,vf610-usbmisc" for Vybrid vf610
 	"fsl,imx6sx-usbmisc" for imx6sx
+	"fsl,imx7d-usbmisc" for imx7d
 - reg: Should contain registers location and length
 
 Examples:
-- 
1.9.1
