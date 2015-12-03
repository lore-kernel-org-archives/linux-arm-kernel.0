From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu,  3 Dec 2015 16:10:31 -0500
Subject: [PATCH v5 2/7] of: Add vendor prefix for General Electric Company
In-Reply-To: <1449177036-13317-1-git-send-email-akshay.bhat@timesys.com>
References: <1449177036-13317-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1449177036-13317-3-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds vendor prefix for General Electric Company

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index c51bf7c..f1cc839 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -88,6 +88,7 @@ fcs	Fairchild Semiconductor
 firefly	Firefly
 focaltech	FocalTech Systems Co.,Ltd
 fsl	Freescale Semiconductor
+ge	General Electric Company
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 geniatech	Geniatech, Inc.
-- 
2.6.3
