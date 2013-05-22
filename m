From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 May 2013 15:22:55 +0100
Subject: [PATCH 1/7] ARM: ux500: Standardise DBx5x0 based Pinctrl compat
 string in the DTS
In-Reply-To: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
References: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1369232581-18923-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 6c25fbe..d0835ca 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -171,7 +171,7 @@
 		};
 
 		pinctrl {
-			compatible = "stericsson,nmk-pinctrl";
+			compatible = "stericsson,db8500-pinctrl";
 			prcm = <&prcmu>;
 		};
 
-- 
1.7.10.4
