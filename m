From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat,  7 Jan 2017 10:52:03 +0200
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: Enable power sequence for Odroid
 U3
In-Reply-To: <20170107085203.4431-1-krzk@kernel.org>
References: <20170107085203.4431-1-krzk@kernel.org>
Message-ID: <20170107085203.4431-5-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Odroid U3 needs a power sequence for lan9730, if it was enabled by
bootloader.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b01a43851294..1750d99862b9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -443,6 +443,7 @@ CONFIG_POWER_RESET_RMOBILE=y
 CONFIG_POWER_RESET_ST=y
 CONFIG_POWER_AVS=y
 CONFIG_ROCKCHIP_IODOMAIN=y
+CONFIG_PWRSEQ_GENERIC=y
 CONFIG_SENSORS_IIO_HWMON=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
-- 
2.9.3
