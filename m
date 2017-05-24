From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 24 May 2017 15:54:15 +0200
Subject: [PATCH 7/7] arm64: defconfig: enable fan53555 regulator
In-Reply-To: <20170524135415.5590-1-heiko@sntech.de>
References: <20170524135415.5590-1-heiko@sntech.de>
Message-ID: <20170524135415.5590-8-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fan53555 or its register-compatible cousins Silergy syr827 and syr828
are often used on Rockchip socs as cpu-supply next to regular pmic.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1716ed326f68..97c123e09e45 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -312,6 +312,7 @@ CONFIG_MFD_MAX77620=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_SEC_CORE=y
+CONFIG_REGULATOR_FAN53555=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_HI655X=y
-- 
2.11.0
