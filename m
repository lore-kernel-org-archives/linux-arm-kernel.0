From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 07 Aug 2013 14:15:20 +0530
Subject: [PATCH V3 1/3] platform: Increase platform name size
In-Reply-To: <1375865122-5258-1-git-send-email-padma.v@samsung.com>
References: <1375865122-5258-1-git-send-email-padma.v@samsung.com>
Message-ID: <1375865122-5258-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch increases the platform name size from 20 to 30 as one of
i2s platform_device name in this patchset crosses the limit.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 include/linux/mod_devicetable.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 45e9214..3a2c079 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -479,7 +479,7 @@ struct dmi_system_id {
 #define DMI_MATCH(a, b)	{ .slot = a, .substr = b }
 #define DMI_EXACT_MATCH(a, b)	{ .slot = a, .substr = b, .exact_match = 1 }
 
-#define PLATFORM_NAME_SIZE	20
+#define PLATFORM_NAME_SIZE	30
 #define PLATFORM_MODULE_PREFIX	"platform:"
 
 struct platform_device_id {
-- 
1.7.4.4
