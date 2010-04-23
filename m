From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Apr 2010 16:12:10 -0700
Subject: [PATCH 28/28] omap: delete unused bootloader tag variables
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Message-ID: <20100423231210.31953.2729.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Aaro Koskinen <Aaro.Koskinen@nokia.com>

They are not needed and add over 512 bytes to kernel data.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/common.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 01cbb48..f12f0e3 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -44,9 +44,6 @@
 
 #define NO_LENGTH_CHECK 0xffffffff
 
-unsigned char omap_bootloader_tag[512];
-int omap_bootloader_tag_len;
-
 struct omap_board_config_kernel *omap_board_config;
 int omap_board_config_size;
 
