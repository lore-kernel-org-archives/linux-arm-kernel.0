From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Tue, 23 Oct 2012 18:47:53 +0530
Subject: [PATCH v2] ARM: dm365: replace V4L2_OUT_CAP_CUSTOM_TIMINGS with
 V4L2_OUT_CAP_DV_TIMINGS
Message-ID: <1350998273-19769-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lad, Prabhakar <prabhakar.lad@ti.com>

This patch replaces V4L2_OUT_CAP_CUSTOM_TIMINGS macro with
V4L2_OUT_CAP_DV_TIMINGS. As V4L2_OUT_CAP_CUSTOM_TIMINGS is being phased
out.

Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>
---
 Changes for v2:
 1: fixed code  alignment as pointed by Sergei

 arch/arm/mach-davinci/board-dm365-evm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 2924d61..8519d2d 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -514,7 +514,7 @@ static struct vpbe_output dm365evm_vpbe_outputs[] = {
 			.index		= 1,
 			.name		= "Component",
 			.type		= V4L2_OUTPUT_TYPE_ANALOG,
-			.capabilities	= V4L2_OUT_CAP_CUSTOM_TIMINGS,
+			.capabilities	= V4L2_OUT_CAP_DV_TIMINGS,
 		},
 		.subdev_name	= VPBE_VENC_SUBDEV_NAME,
 		.default_mode	= "480p59_94",
-- 
1.7.4.1
