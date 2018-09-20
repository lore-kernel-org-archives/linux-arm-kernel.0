From: linux.amoon@gmail.com (Anand Moon)
Date: Thu, 20 Sep 2018 17:58:20 +0000
Subject: [PATCHv3 1/7] ARM: dts: exynos5422: Added UHS-I bus speed support
In-Reply-To: <20180920175826.1284-1-linux.amoon@gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
Message-ID: <20180920175826.1284-2-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added support for UHS-I bus speed tuning for SDR50, DDR50 SDR104.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376263.html
Changes from above.
Fix the subject and commit message.
drop sd-uhs-sdr12 and sd-uhs-sdr25 as host driver is not enable as of now
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 2f4f40882dab..3a58c935c52a 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -370,6 +370,9 @@
 	cap-sd-highspeed;
 	vmmc-supply = <&ldo19_reg>;
 	vqmmc-supply = <&ldo13_reg>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sd-uhs-ddr50;
 };
 
 &nocp_mem0_0 {
-- 
2.17.1
