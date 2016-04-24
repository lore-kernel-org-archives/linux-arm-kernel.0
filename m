From: colin.king@canonical.com (Colin King)
Date: Sun, 24 Apr 2016 23:02:09 +0100
Subject: [PATCH] pinctrl: sirf/atlas7: trivial fix of spelling mistake on
 flagged
Message-ID: <1461535329-19935-1-git-send-email-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

fix spelling mistake, flaged -> flagged

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/sirf/pinctrl-atlas7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
index 3d233fc..168c0f5 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -5798,7 +5798,7 @@ static void atlas7_gpio_handle_irq(struct irq_desc *desc)
 
 	status = readl(ATLAS7_GPIO_INT_STATUS(bank));
 	if (!status) {
-		pr_warn("%s: gpio [%s] status %#x no interrupt is flaged\n",
+		pr_warn("%s: gpio [%s] status %#x no interrupt is flagged\n",
 			__func__, gc->label, status);
 		handle_bad_irq(desc);
 		return;
-- 
2.7.4
