From: ms@sk.2-ch.org (Mike Solovyev)
Date: Wed, 12 May 2010 23:20:29 +0400
Subject: [PATCH] h1940: framebuffer configuration fix
Message-ID: <20100512232029.a5ce9d0f.ms@sk.2-ch.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seems like a typo, wrong setup leads to broken image on ipaq screen.

Signed-off-by: Mike Solovyev <ms@sk.2-ch.org>
Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---
 arch/arm/mach-s3c2410/mach-h1940.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/arm/mach-s3c2410/mach-h1940.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-s3c2410/mach-h1940.c
+++ linux-2.6/arch/arm/mach-s3c2410/mach-h1940.c
@@ -162,8 +162,8 @@ static struct s3c2410fb_display h1940_lc
 	.xres =		240,
 	.yres =		320,
 	.bpp =		16,
-	.left_margin =	20,
-	.right_margin =	8,
+	.left_margin =	8,
+	.right_margin =	20,
 	.hsync_len =	4,
 	.upper_margin =	8,
 	.lower_margin = 7,
