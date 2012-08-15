From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 15 Aug 2012 17:22:34 +0800
Subject: [PATCH V2 6/6] ARM: tegra: defconfig: enable HOTPLUG_CPU
In-Reply-To: <1345022554-26292-1-git-send-email-josephl@nvidia.com>
References: <1345022554-26292-1-git-send-email-josephl@nvidia.com>
Message-ID: <1345022554-26292-7-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable HOTPLUG_CPU after the SoC specific code to hotplug a CPU
been merged.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index db22453..e16fd61 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -31,6 +31,7 @@ CONFIG_MACH_PAZ00=y
 CONFIG_MACH_TRIMSLICE=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
 CONFIG_SMP=y
+CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
-- 
1.7.0.4
