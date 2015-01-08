From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu,  8 Jan 2015 08:24:45 +0100
Subject: [PATCH 1/3] soc/tegra: Add Tegra132 support
Message-ID: <1420701887-1465-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add the chip ID for the NVIDIA Tegra132 SoC family.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/soc/tegra/fuse.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index 8e1249474e84..b5f7b5f8d008 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -21,6 +21,7 @@
 #define TEGRA30		0x30
 #define TEGRA114	0x35
 #define TEGRA124	0x40
+#define TEGRA132	0x13
 
 #define TEGRA_FUSE_SKU_CALIB_0	0xf0
 #define TEGRA30_FUSE_SATA_CALIB	0x124
-- 
2.1.3
