From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Sun, 18 Nov 2018 17:17:01 +0300
Subject: [RFC PATCH v2 02/14] dt-bindings: arm: Add new Allwinner ARMv5
 F1C100s SoC
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Message-ID: <5ef0af61c17ae1fd523f15673042f63461e57cff.1542546735.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new Allwinner ARMv5 F1C100s SoC's compatible string

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index e4beec3..12f1b00 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -3,6 +3,7 @@ Allwinner sunXi Platforms Device Tree Bindings
 Each device tree must specify which Allwinner SoC it uses,
 using one of the following compatible strings:
 
+  allwinner,suniv-f1c100s
   allwinner,sun4i-a10
   allwinner,sun5i-a10s
   allwinner,sun5i-a13
-- 
2.7.4
