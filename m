From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Apr 2015 22:31:12 +0800
Subject: [PATCH 11/11] MAINTAINERS: add new folders into IMX entry
In-Reply-To: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1430058672-9267-12-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new created folders drivers/clk/imx/ and include/soc/imx/ into IMX
entry.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8cf9a8a..6827c295f965 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1029,6 +1029,8 @@ F:	arch/arm/mach-imx/
 F:	arch/arm/mach-mxs/
 F:	arch/arm/boot/dts/imx*
 F:	arch/arm/configs/imx*_defconfig
+F:	drivers/clk/imx/
+F:	include/soc/imx/
 
 ARM/GLOMATION GESBC9312SX MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
1.9.1
