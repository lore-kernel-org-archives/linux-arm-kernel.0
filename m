From: ext-teemu.3.paasikivi@nokia.com (Teemu Paasikivi)
Date: Thu, 16 Sep 2010 13:17:40 +0300
Subject: [PATCH v6 1/7] wl12xx: make wl12xx.h common to both spi and sdio
In-Reply-To: <1284592929-29616-2-git-send-email-ohad@wizery.com>
References: <1284592929-29616-1-git-send-email-ohad@wizery.com>
	<1284592929-29616-2-git-send-email-ohad@wizery.com>
Message-ID: <1284632260.23784.10.camel@paavo-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-16 at 01:22 +0200, ext Ohad Ben-Cohen wrote:
> Move wl12xx.h outside of the spi-specific location,
> so it can be shared with both spi and sdio solutions.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
Hi,


wl12xx.h seems to be included also in 
arch/arm/mach-omap2/board-rx51-peripherals.c, so that should be changed
too.


Best Regards,

Teemu Paasikivi
