From: jagan@openedev.com (Jagan Teki)
Date: Tue, 14 Mar 2017 15:18:16 +0530
Subject: [PATCH v5 7/8] ARM: imx_v6_v7_defconfig: Select max11801_ts
 touchscreen driver
In-Reply-To: <1489484897-14933-1-git-send-email-jagan@openedev.com>
References: <1489484897-14933-1-git-send-email-jagan@openedev.com>
Message-ID: <1489484897-14933-8-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Select CONFIG_TOUCHSCREEN_MAX11801 so that we can have touchscreen
funtionality by default on Engicam i.CoreM6 Quad boards.

Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v5:
- %s/arm/ARM/g with subject prefix
Changes for v4:
- Newly added patch

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index eaba3b1..842168f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -165,6 +165,7 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_EGALAX=y
 CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
 CONFIG_TOUCHSCREEN_EDT_FT5X06=y
+CONFIG_TOUCHSCREEN_MAX11801=y
 CONFIG_TOUCHSCREEN_MC13783=y
 CONFIG_TOUCHSCREEN_TSC2004=y
 CONFIG_TOUCHSCREEN_TSC2007=y
-- 
1.9.1
