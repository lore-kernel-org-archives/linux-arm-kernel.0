From: vincent.yang.fujitsu@gmail.com (Vincent Yang)
Date: Thu, 20 Nov 2014 20:39:25 +0800
Subject: [PATCH 8/9] of: add Fujitsu vendor prefix
In-Reply-To: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <1416487165-25551-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 'fujitsu' as the vendor prefix for Fujitsu Semiconductor Ltd.

Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 723999d..dbb7c97 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -56,6 +56,7 @@ everest	Everest Semiconductor Co. Ltd.
 excito	Excito
 fcs	Fairchild Semiconductor
 fsl	Freescale Semiconductor
+fujitsu Fujitsu Semiconductor Ltd.
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 geniatech	Geniatech, Inc.
-- 
1.9.0
