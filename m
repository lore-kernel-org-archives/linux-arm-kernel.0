From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 25 Aug 2016 15:19:49 +0800
Subject: [PATCH v8 01/11] mfd: act8945a: Add .of_compatible for
 act8945a-charger
In-Reply-To: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1472109599-21915-2-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To regard the act8945a-charger as a sub-device, add .of_compatible for
act8945a-charger cell.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mfd/act8945a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/act8945a.c b/drivers/mfd/act8945a.c
index 10c6d2d..a4024d9 100644
--- a/drivers/mfd/act8945a.c
+++ b/drivers/mfd/act8945a.c
@@ -23,6 +23,7 @@ static const struct mfd_cell act8945a_devs[] = {
 	},
 	{
 		.name = "act8945a-charger",
+		.of_compatible = "active-semi,act8945a-charger",
 	},
 };
 
-- 
2.7.4
