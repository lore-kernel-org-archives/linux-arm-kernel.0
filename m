From: dja@axtens.net (Daniel Axtens)
Date: Sat,  2 Dec 2017 20:40:15 +1100
Subject: [PATCH] pinctrl: pxa2xx: add MODULE_LICENSE
Message-ID: <20171202094015.11696-1-dja@axtens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following warning on an allmodconfig build:
WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pxa/pinctrl-pxa2xx.o

This matches the license in the header.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index 866aa3ce1ac9..3d67fca5ae21 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -436,3 +436,5 @@ int pxa2xx_pinctrl_exit(struct platform_device *pdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pxa2xx_pinctrl_exit);
+
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
