From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 17 Apr 2012 11:40:02 +0530
Subject: [PATCH V1 2/2] ARM: config: tegra: add ISL29028
In-Reply-To: <1334643002-6337-1-git-send-email-ldewangan@nvidia.com>
References: <1334643002-6337-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1334643002-6337-3-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ALS and prosimity sensor ISL29028 config.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 351d670..2ad3e3b 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -137,6 +137,7 @@ CONFIG_RTC_DRV_TEGRA=y
 CONFIG_STAGING=y
 CONFIG_IIO=y
 CONFIG_SENSORS_ISL29018=y
+CONFIG_SENSORS_ISL29028=y
 CONFIG_SENSORS_AK8975=y
 CONFIG_MFD_NVEC=y
 CONFIG_KEYBOARD_NVEC=y
-- 
1.7.1.1
