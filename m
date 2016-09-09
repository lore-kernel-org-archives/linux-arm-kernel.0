From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 9 Sep 2016 16:42:00 +0200
Subject: [PATCH v5 5/9] Documentation: dt-bindings: Add IRQ related properties
 of STM32 pinctrl
In-Reply-To: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
References: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1473432124-6784-6-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index 587bffb..a0eed99 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -14,6 +14,9 @@ Required properies:
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
