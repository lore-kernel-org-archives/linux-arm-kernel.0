From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 15 Oct 2018 13:27:39 +0000
Subject: [PATCH v2 4/4] ARM: imx_v6_v7_defconfig: Enable CRYPTO_DEV_MXS_DCP
In-Reply-To: <cover.1539609921.git.leonard.crestez@nxp.com>
References: <cover.1539609921.git.leonard.crestez@nxp.com>
Message-ID: <275ca8850bd5863f79bcafdb11cf9544318a691f.1539609921.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This block is present in 6sl, 6sll and 6ull so it should be enabled in
the default imx kernel config.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 1ad5736c8fa6..57928dff9bce 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -428,10 +428,11 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=y
 CONFIG_SECURITYFS=y
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
 CONFIG_CRYPTO_DEV_SAHARA=y
+CONFIG_CRYPTO_DEV_MXS_DCP=y
 CONFIG_CRC_CCITT=m
 CONFIG_CRC_T10DIF=y
 CONFIG_CRC7=m
 CONFIG_LIBCRC32C=m
 CONFIG_FONTS=y
-- 
2.17.1
