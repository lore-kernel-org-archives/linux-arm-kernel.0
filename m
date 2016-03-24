From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 24 Mar 2016 17:49:59 +0100
Subject: [PATCH v3 02/18] dt-bindings: timer: sp804: add new compatible for
 OX810SE SoC
In-Reply-To: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1458838215-23314-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new oxsemi,ox810se-rps-timer compatible string to support the
PLX Technology OX810SE SoC Dual Timers variant.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/timer/arm,sp804.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,sp804.txt b/Documentation/devicetree/bindings/timer/arm,sp804.txt
index 5cd8eee7..ebe8753 100644
--- a/Documentation/devicetree/bindings/timer/arm,sp804.txt
+++ b/Documentation/devicetree/bindings/timer/arm,sp804.txt
@@ -2,7 +2,7 @@ ARM sp804 Dual Timers
 ---------------------------------------
 
 Required properties:
-- compatible: Should be "arm,sp804" & "arm,primecell"
+- compatible: Should be "arm,sp804" & "arm,primecell", or "oxsemi,ox810se-rps-timer"
 - interrupts: Should contain the list of Dual Timer interrupts. This is the
 	interrupt for timer 1 and timer 2. In the case of a single entry, it is
 	the combined interrupt or if "arm,sp804-has-irq" is present that
-- 
1.9.1
