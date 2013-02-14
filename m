From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 14 Feb 2013 15:05:01 -0800
Subject: [PATCH 7/9] ARM defconfigs: add missing inclusions of
 linux/platform_device.h
In-Reply-To: <1360880818-4071454-8-git-send-email-arnd@arndb.de>
References: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
 <1360880818-4071454-8-git-send-email-arnd@arndb.de>
Message-ID: <20130214230501.GA30269@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 11:26:56PM +0100, Arnd Bergmann wrote:
> Patch 16559ae "kgdb: remove #include <linux/serial_8250.h> from kgdb.h"
> removed an implicit inclusion of linux/platform_device.h
> In a number of places. This adds back explicit inclusions in a few
> more places I found.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> ---
>  arch/arm/plat-samsung/include/plat/adc.h | 1 +
>  drivers/video/clps711xfb.c               | 1 +
>  drivers/video/mmp/fb/mmpfb.c             | 1 +

This file isn't my tty tree, so I can't apply that part of the patch,
but I've applied the rest of the patch, and the 2 others you sent me to
fix this issue.

thanks,

greg k-h
