From: shiju.jose@huawei.com (Shiju Jose)
Date: Fri, 4 Aug 2017 12:23:18 +0100
Subject: [RFC PATCH v4.13-rc3] arm64: defconfig: enable EDAC GHES option
Message-ID: <a0846b9e-f92f-a361-01e6-2594e56d8edd@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable EDAC GHES support for ARM64,
so that memory errors are reported to the user space.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6c7d147..50429c0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -438,6 +438,7 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_EDAC=y
+CONFIG_EDAC_GHES=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
-- 
1.9.1
