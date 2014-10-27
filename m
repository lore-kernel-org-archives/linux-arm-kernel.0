From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 27 Oct 2014 16:03:45 +0100
Subject: [PATCH 7/8] mfd/regulator: dt-bindings: max77686: Document gpio
 property
In-Reply-To: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414422226-10948-8-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document usage of gpio property which turns on external control over
regulator.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 Documentation/devicetree/bindings/mfd/max77686.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max77686.txt b/Documentation/devicetree/bindings/mfd/max77686.txt
index 75fdfaf41831..e41dfa7e2b90 100644
--- a/Documentation/devicetree/bindings/mfd/max77686.txt
+++ b/Documentation/devicetree/bindings/mfd/max77686.txt
@@ -39,6 +39,9 @@ to get matched with their hardware counterparts as follow:
 	-BUCKn	:	1-4.
   Use standard regulator bindings for it ('regulator-off-in-suspend').
 
+  Optional properties:
+  - gpio : GPIO to use for external control. Valid only for LDO20, LDO21,
+    LDO22, BUCK8 and BUCK9 regulators.
 
 Example:
 
-- 
1.9.1
