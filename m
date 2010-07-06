From: luciano.coelho@nokia.com (Luciano Coelho)
Date: Tue, 06 Jul 2010 10:08:28 +0300
Subject: [PATCH 08/15] wireless: wl1271: make wl12xx.h common to both
	spi and sdio
In-Reply-To: <1278376666-3509-9-git-send-email-ohad@wizery.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-9-git-send-email-ohad@wizery.com>
Message-ID: <1278400108.18287.14.camel@chilepepper>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-06 at 02:37 +0200, ext Ohad Ben-Cohen wrote:
> From: Ohad Ben-Cohen <ohadb@ti.com>
> 
> Move wl12xx.h outside of the spi-specific location,
> so it can be shared with both spi and sdio solutions.
> 
> Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
> ---
>  drivers/net/wireless/wl12xx/wl1251_sdio.c |    2 +-
>  drivers/net/wireless/wl12xx/wl1251_spi.c  |    2 +-
>  drivers/net/wireless/wl12xx/wl1271_spi.c  |    2 +-
>  include/linux/spi/wl12xx.h                |   34
> -----------------------------
>  include/linux/wl12xx.h                    |   34
> +++++++++++++++++++++++++++++
>  5 files changed, 37 insertions(+), 37 deletions(-)
>  delete mode 100644 include/linux/spi/wl12xx.h
>  create mode 100644 include/linux/wl12xx.h 

For the wl1271 part:

Acked-by: Luciano Coelho <luciano.coelho@nokia.com>

For the wl12xx.h and wl1251 parts, this needs to be acked by Kalle Valo.


-- 
Cheers,
Luca.
