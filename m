From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 20 Dec 2012 11:43:59 +0200
Subject: [PATCH 1/9] ARM: tegra: fuse: Add chipid TEGRA114 0x35
In-Reply-To: <1355996654-6579-1-git-send-email-hdoyu@nvidia.com>
References: <1355996654-6579-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1355996654-6579-2-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add tegra_chip_id TEGRA114 0x35

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mach-tegra/fuse.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/fuse.h b/arch/arm/mach-tegra/fuse.h
index ff1383d..da78434 100644
--- a/arch/arm/mach-tegra/fuse.h
+++ b/arch/arm/mach-tegra/fuse.h
@@ -37,6 +37,7 @@ enum tegra_revision {
 
 #define TEGRA20		0x20
 #define TEGRA30		0x30
+#define TEGRA114	0x35
 
 extern int tegra_sku_id;
 extern int tegra_cpu_process_id;
-- 
1.7.9.5
