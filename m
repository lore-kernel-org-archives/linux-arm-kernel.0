From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 4 Mar 2012 18:43:24 +0100
Subject: [PATCH 1/3] ARM: S3C24XX: Fix indentation of dma-s3c2443
In-Reply-To: <201203041842.35420.heiko@sntech.de>
References: <201203041842.35420.heiko@sntech.de>
Message-ID: <201203041843.24907.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spaces seem to have slipped in at some point in the past.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/dma-s3c2443.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/dma-s3c2443.c b/arch/arm/mach-s3c24xx/dma-s3c2443.c
index 1422451..d9e1b3b 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2443.c
@@ -71,11 +71,11 @@ static struct s3c24xx_dma_map __initdata s3c2443_dma_mappings[] = {
 		.name		= "uart1",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART1_0),
 	},
-      	[DMACH_UART2] = {
+	[DMACH_UART2] = {
 		.name		= "uart2",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART2_0),
 	},
-      	[DMACH_UART3] = {
+	[DMACH_UART3] = {
 		.name		= "uart3",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART3_0),
 	},
@@ -87,11 +87,11 @@ static struct s3c24xx_dma_map __initdata s3c2443_dma_mappings[] = {
 		.name		= "uart1",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART1_1),
 	},
-      	[DMACH_UART2_SRC2] = {
+	[DMACH_UART2_SRC2] = {
 		.name		= "uart2",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART2_1),
 	},
-      	[DMACH_UART3_SRC2] = {
+	[DMACH_UART3_SRC2] = {
 		.name		= "uart3",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART3_1),
 	},
-- 
1.7.2.3
