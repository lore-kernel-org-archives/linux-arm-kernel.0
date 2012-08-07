From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 7 Aug 2012 13:34:12 +0200
Subject: [PATCH] pinctrl/nomadik: fix hsi function group list
Message-ID: <1344339252-30978-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@stericsson.com>

Tidy up a small typo in the HSI function group list.

Signed-off-by: Patrice Chotard <patrice.chotard@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik-db8500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik-db8500.c b/drivers/pinctrl/pinctrl-nomadik-db8500.c
index 6f99769..5f3e9d0 100644
--- a/drivers/pinctrl/pinctrl-nomadik-db8500.c
+++ b/drivers/pinctrl/pinctrl-nomadik-db8500.c
@@ -766,7 +766,7 @@ DB8500_FUNC_GROUPS(ipgpio, "ipgpio0_a_1", "ipgpio1_a_1", "ipgpio7_b_1",
 DB8500_FUNC_GROUPS(msp2, "msp2sck_a_1", "msp2_a_1");
 DB8500_FUNC_GROUPS(mc4, "mc4_a_1", "mc4rstn_c_1");
 DB8500_FUNC_GROUPS(mc1, "mc1_a_1", "mc1dir_a_1");
-DB8500_FUNC_GROUPS(hsi, "hsir1_a_1", "hsit1_a_1", "hsit_a_2");
+DB8500_FUNC_GROUPS(hsi, "hsir_a_1", "hsit_a_1", "hsit_a_2");
 DB8500_FUNC_GROUPS(clkout, "clkout_a_1", "clkout_a_2", "clkout_c_1");
 DB8500_FUNC_GROUPS(usb, "usb_a_1");
 DB8500_FUNC_GROUPS(trig, "trig_b_1");
-- 
1.7.11.3
