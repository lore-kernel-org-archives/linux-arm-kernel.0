From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Tue, 25 Apr 2017 10:54:21 +0900
Subject: [PATCH] arm64: dts: exynos: Remove the te-gpios property in the TM2
 boards
References: <CGME20170425015437epcas5p43549d47e69519f43d89ba2de496ba451@epcas5p4.samsung.com>
Message-ID: <1493085261-3488-1-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The decon uses HW-TRIGGER, so TE interrupt is not necessary.
Therefore, remove the te-gpios property in the TM2 dts.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
index 3ff9527..23191eb 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -60,7 +60,6 @@
 		vci-supply = <&ldo28_reg>;
 		reset-gpios = <&gpg0 0 GPIO_ACTIVE_LOW>;
 		enable-gpios = <&gpf1 5 GPIO_ACTIVE_HIGH>;
-		te-gpios = <&gpf1 3 GPIO_ACTIVE_HIGH>;
 	};
 };
 
-- 
1.9.1
