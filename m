From: carlo@caione.org (Carlo Caione)
Date: Wed, 11 Mar 2015 10:00:30 +0100
Subject: [PATCH v2 2/2] documentation: Fix pinctrl docs for Meson8b
In-Reply-To: <1426064430-5826-1-git-send-email-carlo@caione.org>
References: <1426064430-5826-1-git-send-email-carlo@caione.org>
Message-ID: <1426064430-5826-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the compatible string for Meson8b in Meson pinctrl documentation.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index 17e7240..3f6a524 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -1,7 +1,7 @@
 == Amlogic Meson pinmux controller ==
 
 Required properties for the root node:
- - compatible: "amlogic,meson8-pinctrl"
+ - compatible: "amlogic,meson8-pinctrl" or "amlogic,meson8b-pinctrl"
  - reg: address and size of registers controlling irq functionality
 
 === GPIO sub-nodes ===
-- 
1.9.1
