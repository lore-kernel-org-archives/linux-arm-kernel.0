From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 3 Apr 2013 19:21:23 +0200
Subject: [PATCH] pinctrl/nomadik: add device tree bindings for db8540
Message-ID: <1365009683-3757-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@stericsson.com>

This adds a simple device tree binding for db8540 boards.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@stericsson.com>
Reviewed-by: Philippe Langlais <philippe.langlais@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 267d81c..435bf30 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -2111,6 +2111,10 @@ static const struct of_device_id nmk_pinctrl_match[] = {
 		.compatible = "stericsson,nmk-pinctrl",
 		.data = (void *)PINCTRL_NMK_DB8500,
 	},
+	{
+		.compatible = "stericsson,nmk-pinctrl-db8540",
+		.data = (void *)PINCTRL_NMK_DB8540,
+	},
 	{},
 };
 
-- 
1.7.11.3
