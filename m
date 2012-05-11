From: hdoyu@nvidia.com (Hiroshi DOYU)
Date: Fri, 11 May 2012 09:56:26 +0300
Subject: [PATCH 3/3] ARM: tegra: Make TEGRA{20,30}_MC selectable in defconfig
In-Reply-To: <1336719389-28506-1-git-send-email-hdoyu@nvidia.com>
References: <20120511095012.57f737d1b0d2536e0d367a9b@nvidia.com>
 <1336719389-28506-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1336719389-28506-3-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_TEGRA{20,30}_MC depends on CONFIG_MEMORY.

Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 7a90abb..639778d 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -149,6 +149,7 @@ CONFIG_KEYBOARD_NVEC=y
 CONFIG_SERIO_NVEC_PS2=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
+CONFIG_MEMORY=y
 CONFIG_IIO=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-- 
1.7.5.4
