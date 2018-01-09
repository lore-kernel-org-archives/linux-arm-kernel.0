From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 09 Jan 2018 16:59:04 +0900
Subject: [PATCH 7/9] arm64: dts: exynos: Use power key as a wakeup source on
 TM2/TM2E board
In-Reply-To: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
References: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
 <CGME20180109075905epcas2p156b0f057a13fe5ab96753bf77f2bf652@epcas2p1.samsung.com>
Message-ID: <1515484746-10656-8-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the power-key as a wakeup source from suspend/freeze state.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index a77462da4a36..26de0add1254 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -60,6 +60,7 @@
 			linux,code = <KEY_POWER>;
 			label = "power key";
 			debounce-interval = <10>;
+			wakeup-source;
 		};
 
 		volume-up-key {
-- 
1.9.1
