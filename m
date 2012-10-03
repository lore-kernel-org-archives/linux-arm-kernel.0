From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  2 Oct 2012 19:26:37 -0600
Subject: [PATCH] ARM: bcm2835: fix typos in DT binding documentation
Message-ID: <1349227597-5187-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible value shouldn't include ".txt", which was probably cut
and paste from the filename.

Reported-by: Domenico Andreoli <cavokz@gmail.com>
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 .../brcm,bcm2835-armctrl-ic.txt                    |    2 +-
 .../bindings/timer/brcm,bcm2835-system-timer.txt   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
index 548892c..7da578d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
@@ -7,7 +7,7 @@ as "armctrl" in the SoC documentation, hence naming of this binding.
 
 Required properties:
 
-- compatible : should be "brcm,bcm2835-armctrl-ic.txt"
+- compatible : should be "brcm,bcm2835-armctrl-ic"
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
index 2de21c2..844bd5f 100644
--- a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
+++ b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
@@ -7,7 +7,7 @@ free running counter values, and generates an interrupt.
 
 Required properties:
 
-- compatible : should be "brcm,bcm2835-system-timer.txt"
+- compatible : should be "brcm,bcm2835-system-timer"
 - reg : Specifies base physical address and size of the registers.
 - interrupts : A list of 4 interrupt sinks; one per timer channel.
 - clock-frequency : The frequency of the clock that drives the counter, in Hz.
-- 
1.7.9.5
