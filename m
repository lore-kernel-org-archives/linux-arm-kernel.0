From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Tue,  1 Apr 2014 17:02:54 +0300
Subject: [PATCHv3 3/5] net: rfkill: gpio: add ACPI ID for GPS module on Lenovo
 Miix2
In-Reply-To: <1396360976-28657-1-git-send-email-heikki.krogerus@linux.intel.com>
References: <1396360976-28657-1-git-send-email-heikki.krogerus@linux.intel.com>
Message-ID: <1396360976-28657-4-git-send-email-heikki.krogerus@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Lenovo Miix 2 8", BCM4752 is renamed LNV4752.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 net/rfkill/rfkill-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 0adda44..fec3dbf 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -173,6 +173,7 @@ static int rfkill_gpio_remove(struct platform_device *pdev)
 
 static const struct acpi_device_id rfkill_acpi_match[] = {
 	{ "BCM4752", RFKILL_TYPE_GPS },
+	{ "LNV4752", RFKILL_TYPE_GPS },
 	{ },
 };
 
-- 
1.9.1
