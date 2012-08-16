From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 16 Aug 2012 17:31:53 +0800
Subject: [PATCH V3 6/6] ARM: tegra: defconfig: enable HOTPLUG_CPU
In-Reply-To: <1345109513-21553-1-git-send-email-josephl@nvidia.com>
References: <1345109513-21553-1-git-send-email-josephl@nvidia.com>
Message-ID: <1345109513-21553-7-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable HOTPLUG_CPU after the SoC specific code to hotplug a CPU
been merged.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* no change
V2:
* init version

 arch/arm/configs/tegra_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 4f078e0..c7f7c7f 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -31,6 +31,7 @@ CONFIG_TEGRA_PCI=y
 CONFIG_TEGRA_DEBUG_UART_AUTO_ODMDATA=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
 CONFIG_SMP=y
+CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
-- 
1.7.0.4
