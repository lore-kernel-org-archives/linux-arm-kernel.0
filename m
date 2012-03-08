From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu,  8 Mar 2012 15:51:24 +0100
Subject: [PATCH 04/11] regulator: tps6586x: fix typo in debug message
In-Reply-To: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1331218291-16119-5-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/regulator/tps6586x-regulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
index c75fb20..29b615c 100644
--- a/drivers/regulator/tps6586x-regulator.c
+++ b/drivers/regulator/tps6586x-regulator.c
@@ -383,7 +383,7 @@ static int __devinit tps6586x_regulator_probe(struct platform_device *pdev)
 	int id = pdev->id;
 	int err;
 
-	dev_dbg(&pdev->dev, "Probing reulator %d\n", id);
+	dev_dbg(&pdev->dev, "Probing regulator %d\n", id);
 
 	ri = find_regulator_info(id);
 	if (ri == NULL) {
-- 
1.7.9.3
