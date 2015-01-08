From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Jan 2015 18:38:12 +0100
Subject: [PATCH v4 10/12] ARM: mvebu: Document the Device Tree binding for the
 Armada 388 SoC
In-Reply-To: <1420738694-6163-1-git-send-email-gregory.clement@free-electrons.com>
References: <1420738694-6163-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1420738694-6163-11-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the binding documentation of the Armada 38x Soc family with
the Armada 388.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/armada-38x.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/armada-38x.txt b/Documentation/devicetree/bindings/arm/armada-38x.txt
index ad9f8ed4d9bd..202953f1887e 100644
--- a/Documentation/devicetree/bindings/arm/armada-38x.txt
+++ b/Documentation/devicetree/bindings/arm/armada-38x.txt
@@ -15,6 +15,13 @@ Required root node property:
 
 compatible: must contain "marvell,armada385"
 
+In addition, boards using the Marvell Armada 388 SoC shall have the
+following property before the previous one:
+
+Required root node property:
+
+compatible: must contain "marvell,armada388"
+
 Example:
 
 compatible = "marvell,a385-rd", "marvell,armada385", "marvell,armada380";
-- 
1.9.1
