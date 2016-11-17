From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:11:26 +0100
Subject: [PATCH 09/31] ARM: dts: koelsch: Enable UHS-I SDR-104
In-Reply-To: <cover.1479391750.git.horms+renesas@verge.net.au>
References: <cover.1479391750.git.horms+renesas@verge.net.au>
Message-ID: <c67bd5310b99f32045064c4eb57009833852d318.1479391750.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And the sd-uhs-sdr104 property to SDHI0.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index d5c80e6bff22..5405d337d744 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -529,6 +529,7 @@
 	cd-gpios = <&gpio6 6 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	status = "okay";
 };
 
-- 
2.7.0.rc3.207.g0ac5344
