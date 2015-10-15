From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:46:42 +0200
Subject: [PATCH 02/13] ARM: add DT bindings for the ARM11MPCore CPU cluster
In-Reply-To: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444916813-31024-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM11MPCore has a Snoop Control Unit, but references to it
were missing from the DT specification. Define a compatible
string for this unit.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/scu.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/scu.txt b/Documentation/devicetree/bindings/arm/scu.txt
index c447680519bb..08a587875996 100644
--- a/Documentation/devicetree/bindings/arm/scu.txt
+++ b/Documentation/devicetree/bindings/arm/scu.txt
@@ -10,10 +10,13 @@ References:
   Revision r2p0
 - Cortex-A5: see DDI0434B Cortex-A5 MPCore Technical Reference Manual
   Revision r0p1
+- ARM11 MPCore: see DDI0360F ARM 11 MPCore Processor Technical Reference
+  Manial Revision r2p0
 
 - compatible : Should be:
 	"arm,cortex-a9-scu"
 	"arm,cortex-a5-scu"
+	"arm,arm11mp-scu"
 
 - reg : Specify the base address and the size of the SCU register window.
 
-- 
2.4.3
