From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 7 Oct 2011 16:21:59 +0800
Subject: [PATCH 14/26] mtd: nand_h1900 never worked
In-Reply-To: <1317499438-14058-15-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-15-git-send-email-arnd@arndb.de>
Message-ID: <CAMPhdO-wKa7ULnMZCp0mYadref-VB4-+X87te_9Vnr8gno_=xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 2, 2011 at 4:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> This driver has been broken through all of git history and
> cannot even be built. Better mark it as broken. Next stop is
> removing from the tree.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: Jamie Iles <jamie@jamieiles.com>

Acked-by: Eric Miao <eric.y.miao@gmail.com>

> ---
> ?drivers/mtd/nand/Kconfig | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 4c342523..f85af18 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -92,7 +92,7 @@ config MTD_NAND_EDB7312
>
> ?config MTD_NAND_H1900
> ? ? ? ?tristate "iPAQ H1900 flash"
> - ? ? ? depends on ARCH_PXA
> + ? ? ? depends on ARCH_PXA && BROKEN
> ? ? ? ?help
> ? ? ? ? ?This enables the driver for the iPAQ h1900 flash.
>
> --
> 1.7.5.4
>
>
