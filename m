From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  8 Jan 2013 19:15:26 +0100
Subject: [PATCH] power: reset: qnap-poweroff: Fix License String
In-Reply-To: <20130106215509.GD26928@lizard.sbx05280.losalca.wayport.net>
References: <20130106215509.GD26928@lizard.sbx05280.losalca.wayport.net>
Message-ID: <1357668926-20598-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPLv2+ is not a valid license string. Replace it with one that is.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/power/reset/qnap-poweroff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index ca0b476..8af772b 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -121,4 +121,4 @@ module_platform_driver(qnap_power_off_driver);
 
 MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
 MODULE_DESCRIPTION("QNAP Power off driver");
-MODULE_LICENSE("GPLv2+");
+MODULE_LICENSE("GPL v2");
-- 
1.7.10.4
