From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 30 Sep 2015 21:17:46 +0200
Subject: [PATCH 1/5] ARM: dts: rockchip: add rk3288-popmetal board to dtb list
In-Reply-To: <1443640670-21104-1-git-send-email-heiko@sntech.de>
References: <1443640670-21104-1-git-send-email-heiko@sntech.de>
Message-ID: <1443640670-21104-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The popmetal board was not included in the list of Rockchip boards,
so was only built when explicitly called with make rk3288-popmetal.dtb
but not in a generic make dtbs, so add the missing entry.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e09809d..4e4ad2e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -506,6 +506,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3288-evb-rk808.dtb \
 	rk3288-firefly-beta.dtb \
 	rk3288-firefly.dtb \
+	rk3288-popmetal.dtb \
 	rk3288-r89.dtb \
 	rk3288-veyron-jaq.dtb \
 	rk3288-veyron-jerry.dtb \
-- 
2.5.3
