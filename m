From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Wed, 20 Jun 2012 20:36:12 +0200 (CEST)
Subject: [PATCH] gpio/mxc: use the edge_sel feature if available
In-Reply-To: <1469075585.3041816.1340216842779.JavaMail.root@advansee.com>
Message-ID: <1939769993.3042206.1340217371997.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 08:27:22PM +0200, Beno?t Th?baudeau wrote:
> --- linux-next-HEAD-a99225f.orig/drivers/gpio/gpio-mxc.c
> +++ linux-next-HEAD-a99225f/drivers/gpio/gpio-mxc.c
> @@ -30,6 +30,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/module.h>
> +#include <mach/hardware.h>
>  #include <asm-generic/bug.h>
>  #include <asm/mach/irq.h>
>  

This hunk can be dropped.

Beno?t
