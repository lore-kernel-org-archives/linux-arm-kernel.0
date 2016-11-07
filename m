From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 07 Nov 2016 15:39:35 +0530
Subject: [PATCH 5/6] mfd: max8997: Add max8997-clk name in mfd_cell
In-Reply-To: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
References: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1478513376-14307-6-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add max8997-clk in mfd_cell max8997_devs in order to probe
max8997-clk device driver.

CC: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/mfd/max8997.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index bda9ec8..4b809f8 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -48,6 +48,7 @@ static const struct mfd_cell max8997_devs[] = {
 	{ .name = "max8997-muic", },
 	{ .name = "max8997-led", .id = 1 },
 	{ .name = "max8997-led", .id = 2 },
+	{ .name = "max8997-clk",},
 };
 
 #ifdef CONFIG_OF
-- 
2.7.4
