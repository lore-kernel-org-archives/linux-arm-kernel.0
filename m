From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 19 Nov 2017 10:57:27 +0100
Subject: [PATCH] pinctrl: gemini: Add two missing GPIO groups
Message-ID: <20171119095727.27689-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 3512 has two more GPIO groups on GPIO area 0, so let's
make it possible to combine these with the function.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-gemini.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-gemini.c b/drivers/pinctrl/pinctrl-gemini.c
index e9b83e291edf..10f8f3a35fe1 100644
--- a/drivers/pinctrl/pinctrl-gemini.c
+++ b/drivers/pinctrl/pinctrl-gemini.c
@@ -2015,7 +2015,8 @@ static const char * const sflashgrps[] = { "sflashgrp" };
 static const char * const gpio0grps[] = { "gpio0agrp", "gpio0bgrp", "gpio0cgrp",
 					  "gpio0dgrp", "gpio0egrp", "gpio0fgrp",
 					  "gpio0ggrp", "gpio0hgrp", "gpio0igrp",
-					  "gpio0jgrp", "gpio0kgrp" };
+					  "gpio0jgrp", "gpio0kgrp", "gpio0lgrp",
+					  "gpio0mgrp" };
 static const char * const gpio1grps[] = { "gpio1agrp", "gpio1bgrp", "gpio1cgrp",
 					  "gpio1dgrp" };
 static const char * const gpio2grps[] = { "gpio2agrp", "gpio2bgrp", "gpio2cgrp" };
-- 
2.14.3
