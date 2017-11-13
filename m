From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 14 Nov 2017 00:34:21 +0100
Subject: [PATCH v2 2/8] dt-bindings: timer: Add Actions Semi S700
In-Reply-To: <20171113233427.5386-1-afaerber@suse.de>
References: <20171113233427.5386-1-afaerber@suse.de>
Message-ID: <20171113233427.5386-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define a compatible string for the Actions Semi S700 SoC timer.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2: Unchanged
 
 Documentation/devicetree/bindings/timer/actions,owl-timer.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
index e3c28da80cb2..977054f87563 100644
--- a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
+++ b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
@@ -2,6 +2,7 @@ Actions Semi Owl Timer
 
 Required properties:
 - compatible      :  "actions,s500-timer" for S500
+                     "actions,s700-timer" for S700
                      "actions,s900-timer" for S900
 - reg             :  Offset and length of the register set for the device.
 - interrupts      :  Should contain the interrupts.
-- 
2.13.6
