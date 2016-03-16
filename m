From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 16 Mar 2016 14:58:40 +0100
Subject: [PATCH v4 2/8] Documentation: devicetree: Add vendor prefix for
 GeekBuying.com
In-Reply-To: <1458136727-32075-1-git-send-email-afaerber@suse.de>
References: <1458136727-32075-1-git-send-email-afaerber@suse.de>
Message-ID: <1458136727-32075-3-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "geekbuying".

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4: Unchanged
 
 v2 -> v3:
 * Rebased (ge vs. geekbuying)

 v2: New (Heiko)
 
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a4d3fb5a2407..31465805bffc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -90,6 +90,7 @@ firefly	Firefly
 focaltech	FocalTech Systems Co.,Ltd
 fsl	Freescale Semiconductor
 ge	General Electric Company
+geekbuying	GeekBuying
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 geniatech	Geniatech, Inc.
-- 
2.6.2
