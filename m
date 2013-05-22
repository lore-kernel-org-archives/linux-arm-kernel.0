From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 May 2013 15:22:56 +0100
Subject: [PATCH 2/7] ARM: ux500: Standardise Nomadik STN8815 based Pinctrl
 compat string in the DTS
In-Reply-To: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
References: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1369232581-18923-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 4a4aab3..a6c2112 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -84,7 +84,7 @@
 	};
 
 	pinctrl {
-		compatible = "stericsson,nmk-pinctrl-stn8815";
+		compatible = "stericsson,stn8815-pinctrl";
 	};
 
 	/* A NAND flash of 128 MiB */
-- 
1.7.10.4
