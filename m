From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  3 Nov 2016 16:07:23 +0100
Subject: [PATCH v8 1/3] ARM: dts: lager: Enable UHS-I SDR-104
In-Reply-To: <1478185645-25556-1-git-send-email-horms+renesas@verge.net.au>
References: <1478185645-25556-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1478185645-25556-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the sd-uhs-sdr104 property to SDHI0.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 434268262d88..e42748a5fe10 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -575,6 +575,7 @@
 	vqmmc-supply = <&vccq_sdhi0>;
 	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	status = "okay";
 };
 
-- 
2.7.0.rc3.207.g0ac5344
