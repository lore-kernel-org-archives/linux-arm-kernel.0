From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jan 2013 13:13:03 +0000
Subject: [PATCH 15/18] power: ab8500_charger: remove unused defines.
In-Reply-To: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1357909986-9262-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <marcus.xm.cooper@stericsson.com>

Cleanup of the ab8500_charger driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Marcus Cooper <marcus.xm.cooper@stericsson.com>
Reviewed-by: Karl KOMIEROWSKI <karl.komierowski@stericsson.com>
---
 drivers/power/ab8500_charger.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index 30193ea..2769e91 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -115,11 +115,6 @@ enum ab8500_charger_link_status {
 	USB_STAT_CARKIT_1,
 	USB_STAT_CARKIT_2,
 	USB_STAT_ACA_DOCK_CHARGER,
-	USB_STAT_SAMSUNG_USB_PHY_DIS,
-	USB_STAT_SAMSUNG_USB_PHY_ENA,
-	USB_STAT_SAMSUNG_UART_PHY_DIS,
-	USB_STAT_SAMSUNG_UART_PHY_ENA,
-	USB_STAT_MOTOROLA_USB_PHY_ENA,
 };
 
 enum ab8500_usb_state {
-- 
1.7.9.5
