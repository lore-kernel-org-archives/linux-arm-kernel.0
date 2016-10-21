From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 21 Oct 2016 17:57:20 +0200
Subject: [PATCH 2/5] ARM: multi_v7_defconfig: Remove ST_THERMAL_SYSCFG Kconfig
 symbol
In-Reply-To: <1477065443-10668-1-git-send-email-patrice.chotard@st.com>
References: <1477065443-10668-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1477065443-10668-3-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

STiH415/6 SoC support is being removed from the kernel and
was the only platform using this Kconfig symbol

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Cc: <rui.zhang@intel.com>
Cc: <edubezval@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 437d074..15b2f99 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -450,7 +450,6 @@ CONFIG_RCAR_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_DAVINCI_WATCHDOG=m
 CONFIG_EXYNOS_THERMAL=m
-CONFIG_ST_THERMAL_SYSCFG=y
 CONFIG_ST_THERMAL_MEMMAP=y
 CONFIG_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=m
-- 
1.9.1
