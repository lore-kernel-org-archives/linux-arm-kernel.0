From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Aug 2016 09:39:13 +0200
Subject: [RESEND v2 08/10] Documentation: dt: add stmpe1600 compatible string
 to stmpe mfd
In-Reply-To: <1470814755-19447-1-git-send-email-patrice.chotard@st.com>
References: <1470814755-19447-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1470814755-19447-9-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

This patch adds a new compatible string for stmpe mfd to support
stmpe1600 variant.

Signed-off-by: Amelie DELAUNAY <amelie.delaunay@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/mfd/stmpe.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/stmpe.txt b/Documentation/devicetree/bindings/mfd/stmpe.txt
index 3fb68bf..f9065a5 100644
--- a/Documentation/devicetree/bindings/mfd/stmpe.txt
+++ b/Documentation/devicetree/bindings/mfd/stmpe.txt
@@ -4,7 +4,7 @@ STMPE is an MFD device which may expose the following inbuilt devices: gpio,
 keypad, touchscreen, adc, pwm, rotator.
 
 Required properties:
- - compatible                   : "st,stmpe[610|801|811|1601|2401|2403]"
+ - compatible                   : "st,stmpe[610|801|811|1600|1601|2401|2403]"
  - reg                          : I2C/SPI address of the device
 
 Optional properties:
-- 
1.9.1
