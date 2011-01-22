From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 22 Jan 2011 16:18:56 -0200
Subject: [PATCH] ARM: mach-imx/mach-mx25_3ds: Fix section type 
Message-ID: <1295720336-28304-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx25_3ds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index aa76cfd..8382e79 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -180,7 +180,7 @@ static const uint32_t mx25pdk_keymap[] = {
 	KEY(3, 3, KEY_POWER),
 };
 
-static const struct matrix_keymap_data mx25pdk_keymap_data __initdata = {
+static const struct matrix_keymap_data mx25pdk_keymap_data __initconst = {
 	.keymap		= mx25pdk_keymap,
 	.keymap_size	= ARRAY_SIZE(mx25pdk_keymap),
 };
-- 
1.6.0.4
