From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Tue, 25 Feb 2014 14:22:29 +0200
Subject: [PATCHv2 4/5] net: rfkill: gpio: add ACPI ID for GPS module on Lenove
 Miix2
In-Reply-To: <1393330950-7283-1-git-send-email-heikki.krogerus@linux.intel.com>
References: <1393330950-7283-1-git-send-email-heikki.krogerus@linux.intel.com>
Message-ID: <1393330950-7283-5-git-send-email-heikki.krogerus@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Lenovo Miix 2 8", BCM4752 is renamed LNV4752.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 net/rfkill/rfkill-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index ad5e354..ec38884 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -158,6 +158,7 @@ static int rfkill_gpio_remove(struct platform_device *pdev)
 
 static const struct acpi_device_id rfkill_acpi_match[] = {
 	{ "BCM4752", RFKILL_TYPE_GPS },
+	{ "LNV4752", RFKILL_TYPE_GPS },
 	{ },
 };
 
-- 
1.9.0.rc3
