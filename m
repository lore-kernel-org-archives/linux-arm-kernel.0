From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 31 Jul 2014 07:36:11 +0200
Subject: [PATCH 1/2] ARM: dts: rockchip: remove pinctrl setting from radxarock
 uart2
In-Reply-To: <1507670.CGuyIht1az@diego>
References: <1507670.CGuyIht1az@diego>
Message-ID: <2098126.1x56DQxCLL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We set default pinctrl settings for the uarts in rk3188.dtsi already,
so remove forgotten duplicate.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188-radxarock.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index b7f3423..4195f5a 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -215,8 +215,6 @@
 };
 
 &uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_xfer>;
 	status = "okay";
 };
 
-- 
2.0.1
