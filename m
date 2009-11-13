From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 13 Nov 2009 23:42:40 +0000
Subject: [PATCH] Update Samsung S5PC100 SoC support
In-Reply-To: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
References: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091113234240.GW4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 09:21:44AM +0100, Marek Szyprowski wrote:
> Hello,
> 
> This patch series updates Samsung S5PC100 SoC support. S5PC100 platform
> core has been extended with new clocks hierarchy implementation, gpio lib,
> support for external and gpio interrupts and some basics of power
> management (cpu idle and system reset). Also platform helpers for
> s3c framebuffer, i2c and hsmmc drivers has been added.
> 
> All these patches has been tested on SMDKC100 board.
> 
> This patch series has been prepared against latest ARM Kernel tree from
> http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git/

I'll put up a new git on git.fluff.org once this is processed.
 
> This is a second version of this patch series. I've tried to address all
> the issues reported here on the mailing list.

Hmm, it seems your git-send-email is now putting

From: Kyungmin Park <kyungmin.park@samsung.com>

From: Kyungmin Park <kyungmin.park@samsung.com>

in twice.. wonder what happened here?

I'll edit out these before applying as it is easy enough to sort.

> This patch series includes:
> 
> [PATCH 01/18] ARM: MM: use 64bytes of L1 cache on plat S5PC1xx
> [PATCH 02/18] ARM: S5PC1XX: registers rename
> [PATCH 03/18] ARM: S5PC1XX: clock registers rename
> [PATCH 04/18] ARM: S5PC1XX: clocks reimplementation
> [PATCH 05/18] ARM: S5PC1XX: add GPIO L banks to register definition
> [PATCH 06/18] ARM: S5PC1XX: GPIO registers rename
> [PATCH 07/18] ARM: S5PC1xx: add gpiolib and external/gpio interrupt support
> [PATCH 08/18] ARM: S5PC1XX: add cpu idle and system reset support
> [PATCH 09/18] ARM: S3C: Prepare s3c64xx-specific s3c-fb register definition for reuse
> [PATCH 10/18] ARM: S5PC1xx: add platform helpers for s3c-fb device
> [PATCH 11/18] SMDKC100: enable S3C FrameBuffer
> [PATCH 12/18] drivers: fb: enable S3C FrameBuffer on S5PC1XX platform
> [PATCH 13/18] ARM: S5PC1xx: add platform helpers for i2c adapter devices
> [PATCH 14/18] SMDKC100: add I2C0 and I2C1 buses support
> [PATCH 15/18] drivers: i2c: s3c2410-i2c also on S5PC1XX platform
> [PATCH 16/18] ARM: S5PC1xx: add platform helpers for SDHCI host controllers
> [PATCH 17/18] SMDKC100: add SDHCI controllers 0, 1 and 2 support
> [PATCH 18/18] drivers: MMC: enable SDHCI-S3C on S5PC1XX platform
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
