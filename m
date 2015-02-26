From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:08 +0900
Subject: [PATCH 07/12] ARM: shmobile: mackerel: Remove from MAINTAINERS
In-Reply-To: <cover.1424931560.git.horms+renesas@verge.net.au>
References: <cover.1424931560.git.horms+renesas@verge.net.au>
Message-ID: <d1e068fd24c399d26880456eb5e117a188d4ce70.1424931560.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the mackerel_defconfig from the MAINTAINERS file.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8c..db7c0cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1418,7 +1418,6 @@ F:	arch/arm/configs/ape6evm_defconfig
 F:	arch/arm/configs/armadillo800eva_defconfig
 F:	arch/arm/configs/bockw_defconfig
 F:	arch/arm/configs/kzm9g_defconfig
-F:	arch/arm/configs/mackerel_defconfig
 F:	arch/arm/configs/marzen_defconfig
 F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
-- 
2.1.4
