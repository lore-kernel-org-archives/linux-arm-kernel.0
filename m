From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Wed, 23 Dec 2015 17:00:11 -0500
Subject: [PATCH v6 2/7] of: Add vendor prefix for General Electric Company
In-Reply-To: <1450908016-17384-1-git-send-email-akshay.bhat@timesys.com>
References: <1450908016-17384-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1450908016-17384-3-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds vendor prefix for General Electric Company

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index aa2f36e..6105659 100644
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
