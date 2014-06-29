From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 29 Jun 2014 16:17:00 +0200
Subject: [PATCH v3 3/4] brcmfmac: Fix some wrong register defines
In-Reply-To: <1404051421-24377-1-git-send-email-hdegoede@redhat.com>
References: <1404051421-24377-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1404051421-24377-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/net/wireless/brcm80211/brcmfmac/sdio_host.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/brcm80211/brcmfmac/sdio_host.h b/drivers/net/wireless/brcm80211/brcmfmac/sdio_host.h
index 3deab79..6e6a366 100644
--- a/drivers/net/wireless/brcm80211/brcmfmac/sdio_host.h
+++ b/drivers/net/wireless/brcm80211/brcmfmac/sdio_host.h
@@ -72,12 +72,12 @@
 #define SBSDIO_SPROM_DATA_HIGH		0x10003
 /* sprom indirect access addr byte 0 */
 #define SBSDIO_SPROM_ADDR_LOW		0x10004
-/* sprom indirect access addr byte 0 */
-#define SBSDIO_SPROM_ADDR_HIGH		0x10005
-/* xtal_pu (gpio) output */
-#define SBSDIO_CHIP_CTRL_DATA		0x10006
-/* xtal_pu (gpio) enable */
-#define SBSDIO_CHIP_CTRL_EN		0x10007
+/* gpio select */
+#define SBSDIO_GPIO_SELECT		0x10005
+/* gpio output */
+#define SBSDIO_GPIO_OUT			0x10006
+/* gpio enable */
+#define SBSDIO_GPIO_EN			0x10007
 /* rev < 7, watermark for sdio device */
 #define SBSDIO_WATERMARK		0x10008
 /* control busy signal generation */
-- 
2.0.0
