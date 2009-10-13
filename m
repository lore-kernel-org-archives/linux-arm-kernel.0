From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 13 Oct 2009 10:11:05 +0200
Subject: [PATCH] Update Samsung S5PC100 SoC support
Message-ID: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series updates Samsung S5PC100 SoC support. S5PC100 platform
core has been extended with new clocks hierarchy implementation, gpio lib,
support for external and gpio interrupts and some basics of power
management (cpu idle and system reset). Also platform helpers for
s3c framebuffer, i2c and hsmmc drivers has been added.

All these patches has been tested on SMDKC100 board.

This patch series has been prepared against latest ARM Kernel tree from
http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git/

(I'm really sorry for double-posting this patch series, but at the first
attepmt I used the old address of the ARM Kernel mailing list)

This patch series includes:

[PATCH 01/17] ARM: MM: use 64bytes of L1 cache on plat S5PC1xx
[PATCH 02/17] ARM: S5PC1XX: registers rename
[PATCH 03/17] ARM: S5PC1XX: clock registers rename
[PATCH 04/17] ARM: S5PC1XX: clocks reimplementation
[PATCH 05/17] ARM: S5PC1XX: add GPIO L banks to register definition
[PATCH 06/17] ARM: S5PC1XX: GPIO registers rename
[PATCH 07/17] ARM: S5PC1xx: add gpiolib and external/gpio interrupt support
[PATCH 08/17] ARM: S5PC1XX: add cpu idle and system reset support
[PATCH 09/17] ARM: S5PC1xx: add platform helpers for s3c-fb device
[PATCH 10/17] SMDKC100: enable S3C FrameBuffer
[PATCH 11/17] drivers: fb: enable S3C FrameBuffer on S5PC1XX platform
[PATCH 12/17] ARM: S5PC1xx: add platform helpers for i2c adapter devices
[PATCH 13/17] SMDKC100: add I2C0 and I2C1 buses support
[PATCH 14/17] drivers: i2c: s3c2410-i2c also on S5PC1XX platform
[PATCH 15/17] ARM: S5PC1xx: add platform helpers for SDHCI host controllers
[PATCH 16/17] SMDKC100: add SDHCI controllers 0, 1 and 2 support
[PATCH 17/17] drivers: MMC: enable SDHCI-S3C on S5PC1XX platform

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
