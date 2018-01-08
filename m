From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon,  8 Jan 2018 14:28:40 +0100
Subject: [PATCH 01/20] dt-bindings: timer: Add Actions Semi S700
In-Reply-To: <1bbaef2e-4080-3f54-7db3-a8989acfd691@free.fr>
References: <1bbaef2e-4080-3f54-7db3-a8989acfd691@free.fr>
Message-ID: <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas F?rber <afaerber@suse.de>

Define a compatible string for the Actions Semi S700 SoC timer.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/actions,owl-timer.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
index e3c28da..977054f 100644
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
2.7.4
