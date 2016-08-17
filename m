From: ayaka@soulik.info (Randy Li)
Date: Thu, 18 Aug 2016 01:03:10 +0800
Subject: [PATCH 1/2] ARM: dts: rockchip: remove excess sd properties for
 firefly reload
In-Reply-To: <1471453391-10267-1-git-send-email-ayaka@soulik.info>
References: <19126716.OZv44ZHtAK@diego>
 <1471453391-10267-1-git-send-email-ayaka@soulik.info>
Message-ID: <1471453391-10267-2-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because of a bug in hardware design, the sdcard at firefly
rk3288 reload board can't switch the io voltage level to 1.8v.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm/boot/dts/rk3288-firefly-reload.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rk3288-firefly-reload.dts
index 43145d1..b86419b 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload.dts
+++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
@@ -202,11 +202,6 @@
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
-	sd-uhs-ddr50;
 	card-detect-delay = <200>;
 	disable-wp;
 	num-slots = <1>;
-- 
2.7.4
