From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 May 2014 17:40:18 -0500
Subject: [PATCH v2 08/11] dt/bindings: add compatible string for versatile osc
 clock
In-Reply-To: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
Message-ID: <1401403221-27523-9-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
v2:
- no change

 Documentation/devicetree/bindings/clock/arm-integrator.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/arm-integrator.txt b/Documentation/devicetree/bindings/clock/arm-integrator.txt
index 652914b..ecc6952 100644
--- a/Documentation/devicetree/bindings/clock/arm-integrator.txt
+++ b/Documentation/devicetree/bindings/clock/arm-integrator.txt
@@ -1,4 +1,4 @@
-Clock bindings for ARM Integrator Core Module clocks
+Clock bindings for ARM Integrator and Versatile Core Module clocks
 
 Auxilary Oscillator Clock
 
@@ -12,7 +12,7 @@ parent node.
 
 
 Required properties:
-- compatible: must be "arm,integrator-cm-auxosc"
+- compatible: must be "arm,integrator-cm-auxosc" or "arm,versatile-cm-auxosc"
 - #clock-cells: must be <0>
 
 Optional properties:
-- 
1.9.1
