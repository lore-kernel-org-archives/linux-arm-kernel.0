From: manjunath.hadli@ti.com (Hadli, Manjunath)
Date: Fri, 16 Dec 2011 14:22:06 +0000
Subject: [PATCH v6 01/11] davinci: vpif: remove obsolete header file
 inclusion
In-Reply-To: <1323951120-15876-2-git-send-email-manjunath.hadli@ti.com>
References: <1323951120-15876-1-git-send-email-manjunath.hadli@ti.com>
 <1323951120-15876-2-git-send-email-manjunath.hadli@ti.com>
Message-ID: <E99FAA59F8D8D34D8A118DD37F7C8F75016B9F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Mauro,
  Sekhar needs your ack on this to get a series of mach patches in. Can you please have a look at this?

-Manju 
On Thu, Dec 15, 2011 at 17:41:50, Hadli, Manjunath wrote:
> remove inclusion of header files from vpif.h and vpif_dispaly.c and add appropriate header file for building.
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
> Cc: LMML <linux-media@vger.kernel.org>
> ---
>  drivers/media/video/davinci/vpif.h         |    2 +-
>  drivers/media/video/davinci/vpif_display.c |    2 --
>  2 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/video/davinci/vpif.h b/drivers/media/video/davinci/vpif.h
> index 25036cb..c96268a 100644
> --- a/drivers/media/video/davinci/vpif.h
> +++ b/drivers/media/video/davinci/vpif.h
> @@ -19,7 +19,7 @@
>  #include <linux/io.h>
>  #include <linux/videodev2.h>
>  #include <mach/hardware.h>
> -#include <mach/dm646x.h>
> +#include <linux/i2c.h>
>  #include <media/davinci/vpif_types.h>
>  
>  /* Maximum channel allowed */
> diff --git a/drivers/media/video/davinci/vpif_display.c b/drivers/media/video/davinci/vpif_display.c
> index 286f029..7fa34b4 100644
> --- a/drivers/media/video/davinci/vpif_display.c
> +++ b/drivers/media/video/davinci/vpif_display.c
> @@ -39,8 +39,6 @@
>  #include <media/v4l2-ioctl.h>
>  #include <media/v4l2-chip-ident.h>
>  
> -#include <mach/dm646x.h>
> -
>  #include "vpif_display.h"
>  #include "vpif.h"
>  
> --
> 1.6.2.4
> 
> 
