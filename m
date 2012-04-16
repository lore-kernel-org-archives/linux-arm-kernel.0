From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Apr 2012 10:54:19 -0600
Subject: [PATCH] ARM: tegra: update defconfig
Message-ID: <1334595259-12305-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

New options enabled:
* RUNTIME_PM

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Note: I intend to squash all defconfig changes into a single patch when
applying. This is the only change I currently have though.

 arch/arm/configs/tegra_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 351d670..66c2dce 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -45,6 +45,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
+CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
1.7.0.4
