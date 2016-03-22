From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 22 Mar 2016 11:00:03 +0900
Subject: [PATCH 2/2] ARM: dts: exynos: Enable SSS on Trats2
In-Reply-To: <1458612003-30284-1-git-send-email-k.kozlowski@samsung.com>
References: <1458612003-30284-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1458612003-30284-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Security SubSystem (SSS) on Trats2 (Exynos4412) board which
allows usage of its hardware accelerated AES operations.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index ed017cc7b14f..2bf363c3bf62 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -1286,6 +1286,10 @@
 	};
 };
 
+&sss {
+	status = "okay";
+};
+
 &tmu {
 	vtmu-supply = <&ldo10_reg>;
 	status = "okay";
-- 
2.5.0
