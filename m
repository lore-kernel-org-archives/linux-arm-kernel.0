From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Tue,  9 Jan 2018 11:36:31 +0100
Subject: [PATCH v3 1/7] dt-bindings: mtd: document new nand-rb property
In-Reply-To: <20180109103637.23798-1-miquel.raynal@free-electrons.com>
References: <20180109103637.23798-1-miquel.raynal@free-electrons.com>
Message-ID: <20180109103637.23798-2-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are already an atmel,rb and an allwinner,rb properties, let's not
make other ones and instead use a generic term: nand-rb to define NAND
chips Ready/Busy lines.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 Documentation/devicetree/bindings/mtd/nand.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/nand.txt b/Documentation/devicetree/bindings/mtd/nand.txt
index 133f3813719c..8bb11d809429 100644
--- a/Documentation/devicetree/bindings/mtd/nand.txt
+++ b/Documentation/devicetree/bindings/mtd/nand.txt
@@ -43,6 +43,7 @@ Optional NAND chip properties:
 		     This is particularly useful when only the in-band area is
 		     used by the upper layers, and you want to make your NAND
 		     as reliable as possible.
+- nand-rb: shall contain the native Ready/Busy ids.
 
 The ECC strength and ECC step size properties define the correction capability
 of a controller. Together, they say a controller can correct "{strength} bit
-- 
2.11.0
