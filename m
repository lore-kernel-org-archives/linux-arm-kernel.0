From: code@mmayer.net (Markus Mayer)
Date: Wed,  9 Aug 2017 14:56:32 -0700
Subject: [PATCH v3 4/4] arm64: defconfig: add CONFIG_BRCMSTB_THERMAL
In-Reply-To: <20170809215632.4124-1-code@mmayer.net>
References: <20170809215632.4124-1-code@mmayer.net>
Message-ID: <20170809215632.4124-5-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

Turn on CONFIG_BRCMSTB_THERMAL as module.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6c7d147..2449064 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -304,6 +304,7 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
+CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_WATCHDOG=y
-- 
2.7.4
