From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 20 Mar 2017 09:21:10 +0100
Subject: [PATCH 1/2] ARM: dts: imx25-pinfunc: remove duplicate definition
Message-ID: <20170320082111.3249-1-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was introduced in commit 18e2b50407fb ("ARM: dts: imx25-pinfunc:
more defines").

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
 arch/arm/boot/dts/imx25-pinfunc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
index f840f03ad171..f987afce2f9d 100644
--- a/arch/arm/boot/dts/imx25-pinfunc.h
+++ b/arch/arm/boot/dts/imx25-pinfunc.h
@@ -68,7 +68,6 @@
 
 #define MX25_PAD_A22__A22			0x030 0x000 0x000 0x00 0x000
 #define MX25_PAD_A22__GPIO_2_8			0x030 0x000 0x000 0x05 0x000
-#define MX25_PAD_A22__FEC_TDATA2		0x030 0x000 0x000 0x07 0x000
 #define MX25_PAD_A22__SIM2_VEN1			0x030 0x000 0x000 0x06 0x000
 #define MX25_PAD_A22__FEC_TDATA2		0x030 0x000 0x000 0x07 0x000
 
-- 
2.11.0
