From: baruch@tkos.co.il (Baruch Siach)
Date: Wed,  9 Jun 2010 14:07:02 +0300
Subject: [PATCH 3/3] imx2_wdt: fix section mismatch
In-Reply-To: <cover.1276081393.git.baruch@tkos.co.il>
References: <cover.1276081393.git.baruch@tkos.co.il>
Message-ID: <31360d4c97db0e754d15f27567b4592010bdd831.1276081393.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/imx2_wdt.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index ea25885..2ee7dac 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -330,7 +330,6 @@ static void imx2_wdt_shutdown(struct platform_device *pdev)
 }
 
 static struct platform_driver imx2_wdt_driver = {
-	.probe		= imx2_wdt_probe,
 	.remove		= __exit_p(imx2_wdt_remove),
 	.shutdown	= imx2_wdt_shutdown,
 	.driver		= {
-- 
1.7.1
