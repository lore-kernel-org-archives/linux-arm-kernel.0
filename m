From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Wed, 19 May 2010 18:45:58 +0200
Subject: [PATCH 03/13] eukrea_mbimx27-baseboard: add timings for DVI output
In-Reply-To: <1274287568-30253-2-git-send-email-eric@eukrea.com>
References: <1274287568-30253-1-git-send-email-eric@eukrea.com>
	<1274287568-30253-2-git-send-email-eric@eukrea.com>
Message-ID: <1274287568-30253-3-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |   32 ++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
index 0f201c5..91ab7bb 100644
--- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
@@ -137,6 +137,38 @@ static struct imx_fb_videomode eukrea_mbimx27_modes[] = {
 		},
 		.pcr		= 0xFAD08B80,
 		.bpp		= 16,
+	}, {
+		.mode = {
+			.name		= "DVI-VGA",
+			.refresh	= 60,
+			.xres		= 640,
+			.yres		= 480,
+			.pixclock	= 32000,
+			.hsync_len	= 1,
+			.left_margin	= 35,
+			.right_margin	= 0,
+			.vsync_len	= 1,
+			.upper_margin	= 7,
+			.lower_margin	= 0,
+		},
+		.pcr		= 0xFA208B80,
+		.bpp		= 16,
+	}, {
+		.mode = {
+			.name		= "DVI-SVGA",
+			.refresh	= 60,
+			.xres		= 800,
+			.yres		= 600,
+			.pixclock	= 25000,
+			.hsync_len	= 1,
+			.left_margin	= 35,
+			.right_margin	= 0,
+			.vsync_len	= 1,
+			.upper_margin	= 7,
+			.lower_margin	= 0,
+		},
+		.pcr		= 0xFA208B80,
+		.bpp		= 16,
 	},
 };
 
-- 
1.6.3.3
