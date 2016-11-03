From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  3 Nov 2016 16:07:25 +0100
Subject: [PATCH v8 3/3] ARM: dts: alt: Enable UHS-I SDR-104
In-Reply-To: <1478185645-25556-1-git-send-email-horms+renesas@verge.net.au>
References: <1478185645-25556-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1478185645-25556-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And the sd-uhs-sdr104 property to SDHI0.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 325d3f972c57..ccb80d66076f 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -277,6 +277,7 @@
 	cd-gpios = <&gpio6 6 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio6 7 GPIO_ACTIVE_LOW>;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	status = "okay";
 };
 
-- 
2.7.0.rc3.207.g0ac5344
