From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  5 Nov 2014 16:59:47 +0000
Subject: [PATCH v4 05/11] mtd: nand: Add new generic NAND Device Tree property
 'nand-chip-select'
In-Reply-To: <1415206793-25670-1-git-send-email-lee.jones@linaro.org>
References: <1415206793-25670-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1415206793-25670-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mtd/nand.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/nand.txt b/Documentation/devicetree/bindings/mtd/nand.txt
index b53f92e..1d542c51 100644
--- a/Documentation/devicetree/bindings/mtd/nand.txt
+++ b/Documentation/devicetree/bindings/mtd/nand.txt
@@ -12,6 +12,9 @@
 - nand-ecc-step-size: integer representing the number of data bytes
 		      that are covered by a single ECC step.
 
+- nand-chip-select: integer representing chip number associated with the
+		    described Flash chip.
+
 The ECC strength and ECC step size properties define the correction capability
 of a controller. Together, they say a controller can correct "{strength} bit
 errors per {size} bytes".
-- 
1.9.1
