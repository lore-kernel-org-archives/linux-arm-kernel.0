From: ppisa@pikron.com (Pavel Pisa)
Date: Sat, 24 Nov 2012 09:18:42 +0100
Subject: [PATCH 18/24] MAINTAINERS: remove drivers/mmc/host/imxmmc.*
In-Reply-To: <1353716808-16375-19-git-send-email-cesarb@cesarb.net>
References: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
 <1353716808-16375-19-git-send-email-cesarb@cesarb.net>
Message-ID: <201211240918.42930.ppisa@pikron.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 November 2012 01:26:42 Cesar Eduardo Barros wrote:
> This driver was removed by commit 6187fee (mmc: remove imxmmc driver).
>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pavel Pisa <ppisa@pikron.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
> ---
>  MAINTAINERS | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fc646ef..cac8e49 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4905,12 +4905,6 @@ F:	Documentation/video4linux/meye.txt
>  F:	drivers/media/pci/meye/
>  F:	include/uapi/linux/meye.h
>
> -MOTOROLA IMX MMC/SD HOST CONTROLLER INTERFACE DRIVER
> -M:	Pavel Pisa <ppisa@pikron.com>
> -L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> -S:	Maintained
> -F:	drivers/mmc/host/imxmmc.*
> -
>  MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
>  M:	Jiri Slaby <jirislaby@gmail.com>
>  S:	Maintained

Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

I have still the hardware but have lack resources to keep with current
kernel development for that old HW. We plan to switch to newer i.MX
hardware - hopefully with more bug free MMC/SD support, because MX1
has taken me yer a year of fighting with its bugs (on Linux and RTEMS
as well).

Best wishes,


                Pavel Pisa
    e-mail:     pisa at cmp.felk.cvut.cz
    www:        http://cmp.felk.cvut.cz/~pisa
    university: http://dce.fel.cvut.cz/
    company:    http://www.pikron.com/
