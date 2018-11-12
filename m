From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon, 12 Nov 2018 16:23:42 +0100
Subject: [PATCH v3 4/4] ARM: dts: stm32: enable hwspinlock on stm32mp157c-ed1
In-Reply-To: <20181112152342.6561-1-benjamin.gaignard@st.com>
References: <20181112152342.6561-1-benjamin.gaignard@st.com>
Message-ID: <20181112152342.6561-5-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
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
