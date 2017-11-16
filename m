From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 16 Nov 2017 13:46:52 +0200
Subject: [PATCH 2/2] arm64: defconfig: Enable CONFIG_TEGRA_BPMP_THERMAL
In-Reply-To: <20171116114652.25321-1-mperttunen@nvidia.com>
References: <20171116114652.25321-1-mperttunen@nvidia.com>
Message-ID: <20171116114652.25321-2-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Tegra BPMP thermal sensor support by default, built as a module.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 42711031a72d..d0f05da8baf9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -327,6 +327,7 @@ CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=m
+CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MESON_GXBB_WATCHDOG=m
-- 
2.14.2
