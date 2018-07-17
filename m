From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Tue, 17 Jul 2018 18:06:10 +0200
Subject: [PATCH 5/5] arm64: defconfig: Enable support for SBS battery driver.
In-Reply-To: <20180717160610.26501-1-enric.balletbo@collabora.com>
References: <20180717160610.26501-1-enric.balletbo@collabora.com>
Message-ID: <20180717160610.26501-5-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Chromebooks, like the Samsung Chromebook Plus, come with a
SBS-compliant gas gauges, so enable the support in the default kernel
configuration.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a36e80cce868..e2aaa47c4999 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -350,6 +350,7 @@ CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_SYSCON_REBOOT_MODE=y
+CONFIG_BATTERY_SBS=m
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_LM90=m
-- 
2.18.0
