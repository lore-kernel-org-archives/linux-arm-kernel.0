From: augulis.darius@gmail.com (Darius Augulis)
Date: Mon, 16 Aug 2010 20:43:32 +0300
Subject: [PATCH 2/2] s3c: mach-real6410: add IORESOURCE_IRQ_HIGHLEVEL flag to
	dm9000
In-Reply-To: <20100816173905.14924.62664.stgit@darius-desktop>
References: <20100816173905.14924.62664.stgit@darius-desktop>
Message-ID: <20100816174332.14924.51505.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IORESOURCE_IRQ_HIGHLEVEL irq flag to dm9000 driver
platform data in board mach-real6410.

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-real6410.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 9f79e6b..e130379 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -81,7 +81,7 @@ static struct resource real6410_dm9k_resource[] = {
 	[2] = {
 		.start	= S3C_EINT(7),
 		.end	= S3C_EINT(7),
-		.flags	= IORESOURCE_IRQ,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL
 	}
 };
 
