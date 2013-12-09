From: balbi@ti.com (Felipe Balbi)
Date: Mon, 9 Dec 2013 10:21:23 -0600
Subject: [PATCH v3 13/15] mfd: menelaus: Remove unnecessary definition
In-Reply-To: <1386606085-26838-1-git-send-email-balbi@ti.com>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
Message-ID: <1386606085-26838-13-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

menelaus_i2c_driver isn't referenced on probe, just remove that
unnecessary line. No functional changes.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/menelaus.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 74eae19..c0219b7 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1206,8 +1206,6 @@ static inline void menelaus_rtc_init(struct menelaus_chip *m)
 
 /*-----------------------------------------------------------------------*/
 
-static struct i2c_driver menelaus_i2c_driver;
-
 static int menelaus_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
-- 
1.8.4.GIT
