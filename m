From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 16 Oct 2017 17:46:27 +0530
Subject: [PATCH 9/9] ARM: multi_v7_defconfig: Statically build RTC_DRV_RK808
In-Reply-To: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
References: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1508156187-27519-10-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RTC_DRV_RK808 need to have build statically for the platforms
do use MFB_RK808 so replace module with statical link.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2adef49..6ddc35c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -768,7 +768,7 @@ CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_MAX8998=m
 CONFIG_RTC_DRV_MAX8997=m
 CONFIG_RTC_DRV_MAX77686=y
-CONFIG_RTC_DRV_RK808=m
+CONFIG_RTC_DRV_RK808=y
 CONFIG_RTC_DRV_RS5C372=m
 CONFIG_RTC_DRV_BQ32K=m
 CONFIG_RTC_DRV_PALMAS=y
-- 
2.7.4
