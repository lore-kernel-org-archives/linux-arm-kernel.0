From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Nov 2015 20:31:51 +0900
Subject: [PATCH] dt-bindings: ARM: add arm,cortex-a72 compatible string
Message-ID: <1448364711-31275-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 3a07a87..58e240d 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -157,6 +157,7 @@ nodes to be present and contain the properties described below.
 			    "arm,cortex-a17"
 			    "arm,cortex-a53"
 			    "arm,cortex-a57"
+			    "arm,cortex-a72"
 			    "arm,cortex-m0"
 			    "arm,cortex-m0+"
 			    "arm,cortex-m1"
-- 
1.9.1
