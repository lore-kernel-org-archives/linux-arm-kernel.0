From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 7 Oct 2013 15:31:20 +0800
Subject: [PATCH 2/7] ARM: tegra: add chip ID of Tegra124
In-Reply-To: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
References: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381131085-26116-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add tegra_chip_id 0x40 for Tegra124

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/fuse.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/fuse.h b/arch/arm/mach-tegra/fuse.h
index def7968..c01d047 100644
--- a/arch/arm/mach-tegra/fuse.h
+++ b/arch/arm/mach-tegra/fuse.h
@@ -29,6 +29,7 @@
 #define TEGRA20		0x20
 #define TEGRA30		0x30
 #define TEGRA114	0x35
+#define TEGRA124	0x40
 
 #ifndef __ASSEMBLY__
 enum tegra_revision {
-- 
1.8.4
