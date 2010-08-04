From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed,  4 Aug 2010 13:22:07 +0200
Subject: [PATCH 05/11] [ARM] pxa/z2: Fix flash layout typo
In-Reply-To: <1280920933-3820-1-git-send-email-marek.vasut@gmail.com>
References: <1280920933-3820-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1280920933-3820-5-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/z2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 07d8bd8..f0d0228 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -164,7 +164,7 @@ static struct mtd_partition z2_flash_parts[] = {
 	}, {
 		.name	= "U-Boot Environment",
 		.offset	= 0x40000,
-		.size	= 0x60000,
+		.size	= 0x20000,
 	}, {
 		.name	= "Flash",
 		.offset	= 0x60000,
-- 
1.7.1
