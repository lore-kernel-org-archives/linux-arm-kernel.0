From: vincent.yang.fujitsu@gmail.com (Vincent Yang)
Date: Mon, 15 Dec 2014 15:14:09 +0800
Subject: [PATCH v2 7/8] of: add Fujitsu vendor prefix
In-Reply-To: <1418626369-3004-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1418626369-3004-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <1418627649-3319-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 'fujitsu' as the vendor prefix for Fujitsu Semiconductor Ltd.

Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index cc6151c..3184d1f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -58,6 +58,7 @@ everest	Everest Semiconductor Co. Ltd.
 excito	Excito
 fcs	Fairchild Semiconductor
 fsl	Freescale Semiconductor
+fujitsu Fujitsu Semiconductor Ltd.
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 geniatech	Geniatech, Inc.
-- 
1.9.0
