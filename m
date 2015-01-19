From: vincent.yang.fujitsu@gmail.com (Vincent Yang)
Date: Mon, 19 Jan 2015 18:38:29 +0800
Subject: [PATCH v4 7/8] of: add Fujitsu vendor prefix
In-Reply-To: <1421663016-1327-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1421663016-1327-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <1421663909-1700-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
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
index b1df0ad..4bc8103 100644
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
