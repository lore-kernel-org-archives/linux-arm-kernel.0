From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 May 2014 17:40:17 -0500
Subject: [PATCH v2 07/11] dt/bindings: arm-boards: add binding for Versatile
 core module
In-Reply-To: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
Message-ID: <1401403221-27523-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Add binding for the core module found on ARM versatile AB and PB boards.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
- no change
 Documentation/devicetree/bindings/arm/arm-boards | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index 3509707..c554ed3 100644
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
+  a core-module with regs and the compatible strings
+  "arm,core-module-versatile", "syscon"
-- 
1.9.1
