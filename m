From: wni@nvidia.com (Wei Ni)
Date: Mon, 18 Feb 2013 19:30:31 +0800
Subject: [RFC PATCH 9/9] ARM: tegra: defconfig: enable thermal framework
In-Reply-To: <1361187031-3679-1-git-send-email-wni@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
Message-ID: <1361187031-3679-10-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable tegra30 thermal framework.
New options enabled:
* TEGRA30_THERMAL: for tegra30 thermal framework.
* THERMAL: dependency for TEGRA30_THERMAL.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index a7827fd..4aa3356 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -128,6 +128,8 @@ CONFIG_GPIO_TPS65910=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_SBS=y
 CONFIG_SENSORS_LM90=y
+CONFIG_THERMAL=y
+CONFIG_TEGRA30_THERMAL=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
 CONFIG_MFD_MAX8907=y
-- 
1.7.9.5
