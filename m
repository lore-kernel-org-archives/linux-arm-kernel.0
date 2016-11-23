From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 21:14:15 +0100
Subject: [PATCH 08/31] ARM: dts: lager: Enable UHS-I SDR-104
In-Reply-To: <cover.1479931686.git.horms+renesas@verge.net.au>
References: <cover.1479931686.git.horms+renesas@verge.net.au>
Message-ID: <dcc2fe783d5338125214335b7168623a4b81adbb.1479931686.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the sd-uhs-sdr104 property to SDHI0.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 9b9748548702..bd512c86e852 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -608,6 +608,7 @@
 	vqmmc-supply = <&vccq_sdhi0>;
 	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	status = "okay";
 };
 
-- 
2.7.0.rc3.207.g0ac5344
