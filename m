From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 19 Sep 2017 23:54:54 +0200
Subject: [PATCH v2 1/3] dt-bindings: Add vendor prefix for ProBox2
In-Reply-To: <7c7224a9-b0a6-caa4-483a-d9613af48d13@suse.de>
References: <7c7224a9-b0a6-caa4-483a-d9613af48d13@suse.de>
Message-ID: <20170919215454.5820-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PROBOX2 is a TV box brand by Hong Kong based online reseller W2COMP
Company Limited.

Cc: support at probox2.com
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Extend the vendor prefix explanation with info provided by PROBOX2
 * Fix the commit message accordingly
 
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 9d1a48ba2445..6c6002cf6be6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -264,6 +264,7 @@ plathome	Plat'Home Co., Ltd.
 plda	PLDA
 poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
+probox2	PROBOX2 (by W2COMP Co., Ltd.)
 pulsedlight	PulsedLight, Inc
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
-- 
2.13.5
