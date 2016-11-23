From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 21:14:17 +0100
Subject: [PATCH 10/31] ARM: dts: alt: Enable UHS-I SDR-104
In-Reply-To: <cover.1479931686.git.horms+renesas@verge.net.au>
References: <cover.1479931686.git.horms+renesas@verge.net.au>
Message-ID: <f9f2fc0b8d659158cafa95df4ca1d38b1c081d94.1479931686.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And the sd-uhs-sdr104 property to SDHI0.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 7270d4224b1a..569e3f0e97a5 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -307,6 +307,7 @@
 	cd-gpios = <&gpio6 6 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio6 7 GPIO_ACTIVE_LOW>;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	status = "okay";
 };
 
-- 
2.7.0.rc3.207.g0ac5344
