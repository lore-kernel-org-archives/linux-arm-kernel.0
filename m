From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Tue, 20 Dec 2016 06:41:22 +0100
Subject: [PATCH 2/2] pinctrl: sirf: atlas7: Improve code layout
Message-ID: <20161220054122.25508-1-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some tab in order to improve indentation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pinctrl/sirf/pinctrl-atlas7.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
index f714f67c4b64..76df538fa814 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -5444,7 +5444,7 @@ static int atlas7_pinmux_probe(struct platform_device *pdev)
 		pmx->regs[idx] = of_iomap(np, idx);
 		if (!pmx->regs[idx]) {
 			dev_err(&pdev->dev,
-			"can't map ioc bank#%d registers\n", idx);
+				"can't map ioc bank#%d registers\n", idx);
 			ret = -ENOMEM;
 			goto unmap_io;
 		}
@@ -6057,8 +6057,8 @@ static int atlas7_gpio_probe(struct platform_device *pdev)
 	ret = gpiochip_add_data(chip, a7gc);
 	if (ret) {
 		dev_err(&pdev->dev,
-		"%s: error in probe function with status %d\n",
-		np->name, ret);
+			"%s: error in probe function with status %d\n",
+			np->name, ret);
 		goto failed;
 	}
 
-- 
2.9.3
