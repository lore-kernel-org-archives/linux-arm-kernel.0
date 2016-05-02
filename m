From: carlo@caione.org (Carlo Caione)
Date: Mon,  2 May 2016 10:02:16 +0200
Subject: [PATCH v2 2/4] documentation: Add compatibles for Amlogic Meson GXBB
 pin controllers
In-Reply-To: <1462176138-29433-1-git-send-email-carlo@caione.org>
References: <1462176138-29433-1-git-send-email-carlo@caione.org>
Message-ID: <1462176138-29433-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the two new compatibles for the Amlogic Meson GXBB pin controllers.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index 32f4a2d..fe7fe0b 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -5,6 +5,8 @@ Required properties for the root node:
 		      "amlogic,meson8b-cbus-pinctrl"
 		      "amlogic,meson8-aobus-pinctrl"
 		      "amlogic,meson8b-aobus-pinctrl"
+		      "amlogic,meson-gxbb-periphs-pinctrl"
+		      "amlogic,meson-gxbb-aobus-pinctrl"
  - reg: address and size of registers controlling irq functionality
 
 === GPIO sub-nodes ===
-- 
2.7.4
