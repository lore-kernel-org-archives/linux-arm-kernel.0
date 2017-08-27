From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Aug 2017 14:54:23 +0200
Subject: [PATCH 1/3] dt-bindings: Add vendor prefix for ProBox2
In-Reply-To: <20170827125425.3400-1-afaerber@suse.de>
References: <20170827125425.3400-1-afaerber@suse.de>
Message-ID: <20170827125425.3400-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PROBOX2 is a Hong Kong based manufacturer of TV boxes.

Cc: support at probox2.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 I did not find a fully spelled out company name for this brand.
 
 http://probox2.com/contact-us/
 https://www.facebook.com/pg/probox2/about/
 
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 37867c3cb94b..683b1693078f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -261,6 +261,7 @@ plathome	Plat'Home Co., Ltd.
 plda	PLDA
 poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
+probox2	PROBOX2
 pulsedlight	PulsedLight, Inc
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
-- 
2.12.3
