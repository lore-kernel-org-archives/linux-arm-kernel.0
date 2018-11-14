From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 14 Nov 2018 10:00:27 +0100
Subject: [PATCH v4 4/4] ARM: dts: stm32: enable hwspinlock on stm32mp157c-ed1
In-Reply-To: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
Message-ID: <20181114090027.7580-5-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index f77bea49c079..158a337b3129 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -94,3 +94,7 @@
 	vdda1v1-supply = <&reg11>;
 	vdda1v8-supply = <&reg18>;
 };
+
+&hsem {
+	status = "okay";
+};
-- 
2.15.0
