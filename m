From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 16 Feb 2016 19:14:56 +0100
Subject: [PATCH v4 06/12] Documentation: dt-bindings: Add a new compatible for
 the Armada 3700
In-Reply-To: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1455646502-23834-7-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AHCI interfaces used in the Armada 3700 has a few differences with
the one used in the Armada 38x, so it deserves its own compatible string.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c2340eeeb97f..796e2c23e5df 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -13,6 +13,7 @@ Required properties:
   - "hisilicon,hisi-ahci"
   - "ibm,476gtr-ahci"
   - "marvell,armada-380-ahci"
+  - "marvell,armada-3700-ahci"
   - "snps,dwc-ahci"
   - "snps,exynos5440-ahci"
   - "snps,spear-ahci"
-- 
2.5.0
