From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 13 Sep 2016 12:56:58 +0200
Subject: [PATCH v7 01/11] ARM: dts: lager: Enable UHS-I SDR-104
In-Reply-To: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
References: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1473764228-24768-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the sd-uhs-sdr104 property to SDHI0.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 52b56fcaddf2..5e43763cec65 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -559,6 +559,7 @@
 	vqmmc-supply = <&vccq_sdhi0>;
 	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	status = "okay";
 };
 
-- 
2.7.0.rc3.207.g0ac5344
