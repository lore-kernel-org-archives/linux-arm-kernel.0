From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 24 Mar 2015 17:12:55 +0100
Subject: [PATCH] devicetree: Add vendor prefix for Foxlink Group
Message-ID: <1427213575-27340-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Thierry,

Boris added the support for a Foxlink panel in this commit: 102932b0e474
(drm/panel: add support for Foxlink FL500WVR00-A0T panel). Here is the vendor
prefix.

Bye,

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 1b0f5b797cd5..e9fca088ba1a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -73,6 +73,7 @@ everspin	Everspin Technologies, Inc.
 excito	Excito
 fcs	Fairchild Semiconductor
 firefly	Firefly
+foxlink	Foxlink Group
 fsl	Freescale Semiconductor
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
-- 
2.1.3
