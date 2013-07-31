From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 31 Jul 2013 16:03:23 -0500
Subject: [PATCH] gpio: (gpio-pca953x) move header to linux/platform_data/
In-Reply-To: <1375304231-27281-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1375304231-27281-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DAC5C27C5@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 31, 2013 1:57 PM, Vivien Didelot wrote:
>
> This patch moves the pca953x.h header from include/linux/i2c to
> include/linux/platform_data and updates existing support accordingly.
>
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> ---

<snip>

arch/arm/mach-ep93xx/vision_ep9307.c        |  2 +-

For the ep93xx change:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks
