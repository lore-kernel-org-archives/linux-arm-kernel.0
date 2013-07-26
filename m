From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Fri, 26 Jul 2013 16:17:15 +0200
Subject: [PATCH] ARM: clocksource: moxart: documentation: update device tree
 bindings document
Message-ID: <1374848235-21734-1-git-send-email-jonas.jensen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. describe compatible variable "Must be" instead of "Should be".
2. change description so it's from the point of view of the device

Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---

Notes:
    Hi Daniel,
    
    The device tree bindings document (already merged) needs another update.
    
    Can be applied directly to timers/clockevents-next.
    
    Best regards,
    Jonas

 Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt b/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
index ad0bf7f..da2d510 100644
--- a/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
+++ b/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
@@ -2,10 +2,10 @@ MOXA ART timer
 
 Required properties:
 
-- compatible : Should be "moxa,moxart-timer"
+- compatible : Must be "moxa,moxart-timer"
 - reg : Should contain registers location and length
 - interrupts : Should contain the timer interrupt number
-- clocks : Should contain phandle for the MOXA ART core clock "coreclk"
+- clocks : Should contain phandle for the clock that drives the counter
 
 Example:
 
-- 
1.8.2.1
