From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 11 Jan 2013 19:03:04 +0530
Subject: [PATCH 2/3] ARM: tegra: config: enable KEYBOARD_TEGRA
In-Reply-To: <1357911185-11048-1-git-send-email-ldewangan@nvidia.com>
References: <1357911185-11048-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1357911185-11048-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 254f31f..e350afb 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -107,6 +107,7 @@ CONFIG_BRCMFMAC=m
 CONFIG_RT2X00=y
 CONFIG_RT2800USB=m
 CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_TEGRA=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MPU3050=y
 # CONFIG_LEGACY_PTYS is not set
-- 
1.7.1.1
