From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Fri, 20 Jan 2012 18:58:22 +0100
Subject: [PATCH 1/3] mx31moboard: update maintainer
In-Reply-To: <1327082304-11398-1-git-send-email-philippe.retornaz@epfl.ch>
References: <1327082304-11398-1-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1327082304-11398-2-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-imx/mach-mx31moboard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 9326915..f695a31 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -591,7 +591,7 @@ static void __init mx31moboard_reserve(void)
 }
 
 MACHINE_START(MX31MOBOARD, "EPFL Mobots mx31moboard")
-	/* Maintainer: Valentin Longchamp, EPFL Mobots group */
+	/* Maintainer: Philippe Retornaz, EPFL Mobots group */
 	.atag_offset = 0x100,
 	.reserve = mx31moboard_reserve,
 	.map_io = mx31_map_io,
-- 
1.6.3.3
