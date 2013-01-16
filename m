From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 16 Jan 2013 18:36:11 +0530
Subject: [PATCH 1/2] ARM: tegra: config: enable SERIAL_TEGRA
Message-ID: <1358341572-8154-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable high speed serial driver for tegra platform.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index a7827fd..4c5cc08 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -112,6 +112,7 @@ CONFIG_INPUT_MPU3050=y
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_TEGRA=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
-- 
1.7.1.1
