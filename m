From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 4 Jul 2012 11:26:42 +0200
Subject: [PATCH] pinctrl/nomadik: kerneldoc fix
Message-ID: <1341394002-10393-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Document a missing function parameter to nmk_config_pin().

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 095bbc6..e2a2dd1 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -434,7 +434,7 @@ static int __nmk_config_pins(pin_cfg_t *cfgs, int num, bool sleep)
 /**
  * nmk_config_pin - configure a pin's mux attributes
  * @cfg: pin confguration
- *
+ * @sleep: Non-zero to apply the sleep mode configuration
  * Configures a pin's mode (alternate function or GPIO), its pull up status,
  * and its sleep mode based on the specified configuration.  The @cfg is
  * usually one of the SoC specific macros defined in mach/<soc>-pins.h.  These
-- 
1.7.9.2
