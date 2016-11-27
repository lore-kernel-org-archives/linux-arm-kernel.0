From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Nov 2016 21:57:59 +0100
Subject: [PATCH 2/2] net: dsa: mv88e6xxx: Add 88E6176 device tree support
In-Reply-To: <1480280279-9552-1-git-send-email-afaerber@suse.de>
References: <1480280279-9552-1-git-send-email-afaerber@suse.de>
Message-ID: <1480280279-9552-2-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This model is found on the Turris Omnia.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 77f13ada2612..95b9efb33ec7 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4280,6 +4280,10 @@ static const struct of_device_id mv88e6xxx_of_match[] = {
 		.data = &mv88e6xxx_table[MV88E6085],
 	},
 	{
+		.compatible = "marvell,mv88e6176",
+		.data = &mv88e6xxx_table[MV88E6176],
+	},
+	{
 		.compatible = "marvell,mv88e6190",
 		.data = &mv88e6xxx_table[MV88E6190],
 	},
-- 
2.6.6
