From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 29 Dec 2015 16:41:09 +0000
Subject: [PATCH 2/2] dt-bindings: ci-hdrc-usb2: add missing compatibles
In-Reply-To: <1451407269-14905-1-git-send-email-stefan.wahren@i2se.com>
References: <1451407269-14905-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1451407269-14905-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing compatible strings from ci_hdrc_imx.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index 781296b..1e83509 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -2,7 +2,14 @@
 
 Required properties:
 - compatible: should be one of:
+	"fsl,imx23-usb"
 	"fsl,imx27-usb"
+	"fsl,imx28-usb"
+	"fsl,imx6q-usb"
+	"fsl,imx6sl-usb"
+	"fsl,imx6sx-usb"
+	"fsl,imx6ul-usb"
+	"fsl,imx7d-usb"
 	"lsi,zevio-usb"
 	"qcom,ci-hdrc"
 	"chipidea,usb2"
-- 
1.7.9.5
