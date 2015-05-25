From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Mon, 25 May 2015 21:26:49 +0900
Subject: [PATCH 1/2] of: Add vendor prefix for Hardkernel
Message-ID: <1432556810-11597-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Hardkernel Co., Ltd. to the list of device tree vendor prefixes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 80339192c93e..e8a00b74d8fe 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -90,6 +90,7 @@ gumstix	Gumstix, Inc.
 gw	Gateworks Corporation
 hannstar	HannStar Display Corporation
 haoyu	Haoyu Microelectronic Co. Ltd.
+hardkernel	Hardkernel Co., Ltd
 himax	Himax Technologies, Inc.
 hisilicon	Hisilicon Limited.
 hit	Hitachi Ltd.
-- 
2.1.4
