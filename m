From: vincent.yang.fujitsu@gmail.com (Vincent Yang)
Date: Tue,  3 Feb 2015 17:34:28 +0800
Subject: [PATCH v5 6/7] of: add Fujitsu vendor prefix
In-Reply-To: <1422955310-6542-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1422955310-6542-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <1422956068-6796-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Add 'fujitsu' as the vendor prefix for Fujitsu Semiconductor Ltd.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index d443279..e0ac020 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -59,6 +59,7 @@ everest	Everest Semiconductor Co. Ltd.
 excito	Excito
 fcs	Fairchild Semiconductor
 fsl	Freescale Semiconductor
+fujitsu Fujitsu Semiconductor Ltd.
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 geniatech	Geniatech, Inc.
-- 
1.9.0
