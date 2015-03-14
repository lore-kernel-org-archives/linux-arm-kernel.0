From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 15 Mar 2015 00:59:55 +0100
Subject: [PATCH] MAINTAINERS: add rockchip regexp to the ARM/Rockchip entry
In-Reply-To: <3637038.xZyfPJIQzf@phil>
References: <3637038.xZyfPJIQzf@phil>
Message-ID: <1549608.4TUoCrjlkv@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regexp option is a nice way to catch even weirder paths like the current
drivers/gpu/drm/rockchip/* or others in the future.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
This patch is included in the pull above and only meant for completeness sake
to not hide it in the pull alone.


 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8c..0d273bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1351,6 +1351,7 @@ F:	drivers/i2c/busses/i2c-rk3x.c
 F:	drivers/*/*rockchip*
 F:	drivers/*/*/*rockchip*
 F:	sound/soc/rockchip/
+N:	rockchip
 
 ARM/SAMSUNG EXYNOS ARM ARCHITECTURES
 M:	Kukjin Kim <kgene@kernel.org>
-- 
2.1.4
