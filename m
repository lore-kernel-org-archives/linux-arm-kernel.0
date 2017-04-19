From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 19 Apr 2017 10:01:34 -0700
Subject: [PATCH] soc: bcm: brcmstb: Correctly match 7435 SoC
Message-ID: <20170419170136.4979-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the duplicate brcm,bcm7425-sun-top-ctrl compatible string and
replace it with brcm,bcm7435-sun-top-ctrl which was intentend.

Fixes: bd0faf08dc7f ("soc: bcm: brcmstb: Match additional compatible strings")
Reported-by: Andreas Oberritter <obi@saftware.de>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index b6195fdf0d00..22e98a90468c 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -49,7 +49,7 @@ static const struct of_device_id sun_top_ctrl_match[] = {
 	{ .compatible = "brcm,bcm7420-sun-top-ctrl", },
 	{ .compatible = "brcm,bcm7425-sun-top-ctrl", },
 	{ .compatible = "brcm,bcm7429-sun-top-ctrl", },
-	{ .compatible = "brcm,bcm7425-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7435-sun-top-ctrl", },
 	{ .compatible = "brcm,brcmstb-sun-top-ctrl", },
 	{ }
 };
-- 
2.9.3
