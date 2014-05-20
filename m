From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 May 2014 16:09:33 -0500
Subject: [PATCH 07/10] dt/bindings: arm-boards: add binding for Versatile core
 module
In-Reply-To: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
Message-ID: <1400620176-7239-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Add binding for the core module found on ARM versatile AB and PB boards.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/arm-boards | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index 3509707..3a950d9 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -86,3 +86,9 @@ Interrupt controllers:
 	compatible = "arm,versatile-sic";
 	interrupt-controller;
 	#interrupt-cells = <1>;
+
+Required nodes:
+
+- core-module: the root node to the Versatile platforms must have
+  a core-module with regs and the compatible string
+  "arm,core-module-versatile"
-- 
1.9.1
