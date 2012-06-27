From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Jun 2012 14:42:31 +0200
Subject: [PATCH v7 06/14] USB: Chipidea: rename struct ci13xxx variables
 from udc to ci
In-Reply-To: <1340607391-16380-7-git-send-email-richard.zhao@freescale.com>
References: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
 <1340607391-16380-7-git-send-email-richard.zhao@freescale.com>
Message-ID: <4FEAFFB7.7010906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2012 08:56 AM, Richard Zhao wrote:
> struct ci13xxx represent the controller, which may be device or host,
> so name its variables as ci.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

nitpick: search-replace problem

> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -1,5 +1,5 @@
>  /*
> - * udc.c - ChipIdea UDC driver
> + * ci.c - ChipIdea UDC driver
      ^^^^

:)

>   *
>   * Copyright (C) 2008 Chipidea - MIPS Technologies, Inc. All rights reserved.
>   *
> @@ -66,11 +66,11 @@ static inline int hw_ep_bit(int num, int dir)
>  	return num + (dir ? 16 : 0);
>  }
>  

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/ebce7ba8/attachment-0001.sig>
