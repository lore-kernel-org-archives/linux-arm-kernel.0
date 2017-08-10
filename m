From: horia.geanta@nxp.com (=?UTF-8?q?Horia=20Geant=C4=83?=)
Date: Thu, 10 Aug 2017 20:42:53 +0300
Subject: [RFC PATCH 10/10] arm64: defconfig: enable CAAM crypto engine on
 QorIQ DPAA2 SoCs
In-Reply-To: <20170810174253.20951-1-horia.geanta@nxp.com>
References: <20170810174253.20951-1-horia.geanta@nxp.com>
Message-ID: <20170810174253.20951-11-horia.geanta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CAAM (Cryptographic Accelerator and Assurance Module) driver
for QorIQ Data Path Acceleration Architecture (DPAA) v2.
It handles DPSECI (Data Path SEC Interface) DPAA2 objects that sit
on the Management Complex (MC) fsl-mc bus.

Signed-off-by: Horia Geant? <horia.geanta@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6c7d147eed54..43455ad6fff5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -561,6 +561,7 @@ CONFIG_MEMTEST=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_ECHAINIV=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
+CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=y
 CONFIG_ARM64_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM64_CE=y
 CONFIG_CRYPTO_SHA2_ARM64_CE=y
-- 
2.12.0.264.gd6db3f216544
