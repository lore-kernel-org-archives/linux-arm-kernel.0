From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Wed, 12 Sep 2018 17:07:17 +0100
Subject: [PATCH 1/2] dt-bindings: crypto: hip07-sec, drop incorrect commas
Message-ID: <20180912160718.3324-2-Jonathan.Cameron@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There should not be a comma in the address used for the instance
so drop them.

This is a left over from a review of the final version before
Herbert Xu picked the series up.

Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: 8f026dc887fe ("dt-bindings: Add bidnings for Hisilicon SEC crypto accelerators")
---
 .../devicetree/bindings/crypto/hisilicon,hip07-sec.txt          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/hisilicon,hip07-sec.txt b/Documentation/devicetree/bindings/crypto/hisilicon,hip07-sec.txt
index 78d2db9d4de5..d28fd1af01b4 100644
--- a/Documentation/devicetree/bindings/crypto/hisilicon,hip07-sec.txt
+++ b/Documentation/devicetree/bindings/crypto/hisilicon,hip07-sec.txt
@@ -24,7 +24,7 @@ Optional properties:
 
 Example:
 
-p1_sec_a: crypto at 400,d2000000 {
+p1_sec_a: crypto at 400d2000000 {
 	compatible = "hisilicon,hip07-sec";
 	reg = <0x400 0xd0000000 0x0 0x10000
 	       0x400 0xd2000000 0x0 0x10000
-- 
2.18.0
