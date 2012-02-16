From: balbi@ti.com (Felipe Balbi)
Date: Thu, 16 Feb 2012 11:21:13 +0200
Subject: [PATCH 06/12] ARM: S3C24XX: change the ARCH_S3C2410 to
 ARCH_S3C24XX
In-Reply-To: <1329346545-16373-7-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
 <1329346545-16373-7-git-send-email-kgene.kim@samsung.com>
Message-ID: <20120216092111.GJ1925@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 16, 2012 at 07:55:40AM +0900, Kukjin Kim wrote:
> This patch changes the ARCH name to "ARCH_S3C24XX" for Samsung
> S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443,
> and S3C2450 SoCs so that we can merge the mach-xxx directories
> and plat-s3c24xx dir. to just one mach-s3c24xx for them.
> 
> I think this should be sent to upstream via samsung tree because
> this touches many samsung stuff.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Sangbeom Kim <sbkim73@samsung.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/Kconfig                      |   23 +++++++++++------------
>  arch/arm/Makefile                     |    2 +-
>  arch/arm/boot/compressed/head.S       |    2 +-
>  arch/arm/configs/mini2440_defconfig   |    2 +-
>  arch/arm/configs/s3c2410_defconfig    |    2 +-
>  arch/arm/configs/tct_hammer_defconfig |    2 +-
>  arch/arm/mach-s3c2410/Kconfig         |    2 +-
>  arch/arm/mach-s3c2412/Kconfig         |    4 ++--
>  arch/arm/mach-s3c2416/Kconfig         |    2 +-
>  arch/arm/mach-s3c2443/Kconfig         |    2 +-
>  arch/arm/plat-s3c24xx/Kconfig         |    6 +++---
>  arch/arm/plat-s3c24xx/Makefile        |    2 +-
>  arch/arm/plat-samsung/Kconfig         |    4 ++--
>  drivers/input/touchscreen/Kconfig     |    2 +-
>  drivers/leds/Kconfig                  |    2 +-
>  drivers/mmc/host/Kconfig              |    2 +-
>  drivers/mtd/nand/Kconfig              |    2 +-
>  drivers/rtc/Kconfig                   |    2 +-
>  drivers/spi/Kconfig                   |    2 +-
>  drivers/usb/Kconfig                   |    2 +-
>  drivers/usb/gadget/Kconfig            |    4 ++--

for the gadget part:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120216/49e15eeb/attachment-0001.sig>
