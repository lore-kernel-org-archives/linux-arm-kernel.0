From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 May 2014 16:09:34 -0500
Subject: [PATCH 08/10] dt/bindings: add compatible string for versatile osc
 clock
In-Reply-To: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
Message-ID: <1400620176-7239-9-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
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
