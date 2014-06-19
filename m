From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 19 Jun 2014 16:07:51 +0200
Subject: [PATCH] ARM: mvebu: Fix missing binding documentation for Armada 38x
Message-ID: <1403186871-28204-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the Armada 380 and Armada 385 SoCs, the common bindings for those
2 SoCs, was forgotten. This patch add the documentation for the
marvell,aramda38x property.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Hi,

This fix should be merged in 3.16. For 3.15 I am not sure as it is not
a regression.

Thanks,
Gregory

 Documentation/devicetree/bindings/arm/armada-38x.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/armada-38x.txt b/Documentation/devicetree/bindings/arm/armada-38x.txt
index 11f2330a6554..b68bcb80d2de 100644
--- a/Documentation/devicetree/bindings/arm/armada-38x.txt
+++ b/Documentation/devicetree/bindings/arm/armada-38x.txt
@@ -6,5 +6,9 @@ following property:
 
 Required root node property:
 
+compatible: must contain "marvell,armada38x"
+
+Required root node property:
+
  - compatible: must contain either "marvell,armada380" or
    "marvell,armada385" depending on the variant of the SoC being used.
-- 
1.8.1.2
