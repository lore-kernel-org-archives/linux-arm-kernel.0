From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 24 May 2017 15:54:14 +0200
Subject: [PATCH 6/7] arm64: defconfig: enable Rockchip thermal controller
In-Reply-To: <20170524135415.5590-1-heiko@sntech.de>
References: <20170524135415.5590-1-heiko@sntech.de>
Message-ID: <20170524135415.5590-7-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows to read the cpu and gpu temperatures and affect frequency scaling
if necessary.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f6c50a403f1a..1716ed326f68 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -296,6 +296,7 @@ CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MESON_GXBB_WATCHDOG=m
-- 
2.11.0
