From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 3 Dec 2013 15:36:55 +0800
Subject: [PATCH v4 01/17] usb: doc: phy-mxs: Add more compatible strings
In-Reply-To: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
References: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1386056231-17258-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "fsl,imx6q-usbphy" for imx6dq and imx6dl, add
"fsl,imx6sl-usbphy" for imx6sl.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 Documentation/devicetree/bindings/usb/mxs-phy.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mxs-phy.txt b/Documentation/devicetree/bindings/usb/mxs-phy.txt
index 5835b27..d850e55 100644
--- a/Documentation/devicetree/bindings/usb/mxs-phy.txt
+++ b/Documentation/devicetree/bindings/usb/mxs-phy.txt
@@ -1,7 +1,8 @@
 * Freescale MXS USB Phy Device
 
 Required properties:
-- compatible: Should be "fsl,imx23-usbphy"
+- compatible: "fsl,imx23-usbphy" for imx23 and imx28, "fsl,imx6q-usbphy"
+for imx6dq and imx6dl, "fsl,imx6sl-usbphy" for imx6sl
 - reg: Should contain registers location and length
 - interrupts: Should contain phy interrupt
 
-- 
1.7.8
