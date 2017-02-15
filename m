From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 15 Feb 2017 18:30:12 +0000
Subject: [PATCH] ARM: multi_v7_defconfig: enable some newly added crypto
 modules
Message-ID: <1487183412-25261-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the new accelerated CRC32(C), CRC-T10DIF and ChaCha20 drivers
as modules for multi_v7_defconfig builds.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b01a43851294..597e56047747 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -936,6 +936,9 @@ CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_AES_ARM_CE=m
+CONFIG_CRYPTO_CHACHA20_NEON=m
+CONFIG_CRYPTO_CRC32_ARM_CE=m
+CONFIG_CRYPTO_CRCT10DIF_ARM_CE=m
 CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_DEV_ATMEL_AES=m
 CONFIG_CRYPTO_DEV_ATMEL_TDES=m
-- 
2.7.4
