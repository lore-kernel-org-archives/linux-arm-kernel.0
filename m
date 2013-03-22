From: ian@slimlogic.co.uk (Ian Lartey)
Date: Fri, 22 Mar 2013 13:36:13 +0000
Subject: [PATCH v9 11/11] regulator: palmas remove palmas-charger option from
 DT bindings
In-Reply-To: <1363959373-10671-1-git-send-email-ian@slimlogic.co.uk>
References: <1363959373-10671-1-git-send-email-ian@slimlogic.co.uk>
Message-ID: <1363959373-10671-12-git-send-email-ian@slimlogic.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ian Lartey <ian@slimlogic.co.uk>
---
 drivers/regulator/palmas-regulator.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index a9b558e..6b2d829 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -803,7 +803,6 @@ static int palmas_remove(struct platform_device *pdev)
 
 static struct of_device_id of_palmas_match_tbl[] = {
 	{ .compatible = "ti,palmas-pmic", },
-	{ .compatible = "ti,palmas-charger-pmic", },
 	{ .compatible = "ti,twl6035-pmic", },
 	{ .compatible = "ti,twl6036-pmic", },
 	{ .compatible = "ti,twl6037-pmic", },
-- 
1.7.0.4
