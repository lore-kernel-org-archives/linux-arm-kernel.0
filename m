From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 3 Mar 2014 16:41:44 +0800
Subject: [PATCH v12 01/15] usb: doc: phy-mxs: Add more compatible strings
In-Reply-To: <1393836118-4265-1-git-send-email-peter.chen@freescale.com>
References: <1393836118-4265-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1393836118-4265-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "fsl,imx6q-usbphy" for imx6dq and imx6dl, add
"fsl,imx6sl-usbphy" for imx6sl, and "fsl,imx23-usbphy"
is still a fallback for other strings.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 Documentation/devicetree/bindings/usb/mxs-phy.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mxs-phy.txt b/Documentation/devicetree/bindings/usb/mxs-phy.txt
index 5835b27..ea5134a 100644
--- a/Documentation/devicetree/bindings/usb/mxs-phy.txt
+++ b/Documentation/devicetree/bindings/usb/mxs-phy.txt
@@ -1,7 +1,11 @@
 * Freescale MXS USB Phy Device
 
 Required properties:
-- compatible: Should be "fsl,imx23-usbphy"
+- compatible: should contain:
+	* "fsl,imx23-usbphy" for imx23 and imx28
+	* "fsl,imx6q-usbphy" for imx6dq and imx6dl
+	* "fsl,imx6sl-usbphy" for imx6sl
+  "fsl,imx23-usbphy" is still a fallback for other strings
 - reg: Should contain registers location and length
 - interrupts: Should contain phy interrupt
 
-- 
1.7.8
