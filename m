From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 17 Oct 2015 19:23:54 +0200
Subject: [PATCH 5/9] Documentation: dt-bindings: Add IRQ related properties of
 STM32 pinctrl
In-Reply-To: <1445102638-11575-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1445102638-11575-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1445102638-11575-6-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index 7b4800c..dd95bec 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -13,6 +13,9 @@ Required properies:
  - #size-cells	: The value of this property must be 1
  - ranges	: defines mapping between pin controller node (parent) to
    gpio-bank node (children).
+ - interrupt-parent: phandle of the interrupt parent to which the external
+   GPIO interrupts are forwarded to.
+ - st,syscfg: phandle of the syscfg node used for IRQ mux selection.
  - pins-are-numbered: Specify the subnodes are using numbered pinmux to
    specify pins.
 
-- 
1.9.1
