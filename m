From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 8 Jan 2013 14:47:35 +0200
Subject: [v2 1/9] ARM: tegra: fuse: Add chipid TEGRA114 0x35
In-Reply-To: <1357649263-1098-1-git-send-email-hdoyu@nvidia.com>
References: <1357649263-1098-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1357649263-1098-2-git-send-email-hdoyu@nvidia.com>
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
