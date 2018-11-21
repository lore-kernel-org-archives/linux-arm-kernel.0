From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 21 Nov 2018 14:11:44 +0100
Subject: [PATCH 5/5] ARM: multi_v7_defconfig: Enable Raspberry Pi OTP driver
In-Reply-To: <1542805904-6446-1-git-send-email-stefan.wahren@i2se.com>
References: <1542805904-6446-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1542805904-6446-6-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Raspberry Pi OTP driver, which could be helpful for
custom Compute Module 3 designs.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1c76168..9b7ba43 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -964,6 +964,7 @@ CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_VF610_OCOTP=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
+CONFIG_NVMEM_RASPBERRYPI_OTP=y
 CONFIG_BCM47XX_NVRAM=y
 CONFIG_BCM47XX_SPROM=y
 CONFIG_EFI_VARS=m
-- 
2.7.4
