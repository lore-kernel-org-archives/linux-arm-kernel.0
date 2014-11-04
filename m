From: balbi@ti.com (Felipe Balbi)
Date: Mon, 3 Nov 2014 18:42:41 -0600
Subject: [PATCH] MAINTAINERS: add more files under OMAP SUPPORT
In-Reply-To: <1415061173-9338-1-git-send-email-balbi@ti.com>
References: <1415061173-9338-1-git-send-email-balbi@ti.com>
Message-ID: <20141104004241.GC16754@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 06:32:53PM -0600, Felipe Balbi wrote:
> These files are very important to the healt
> of the OMAP architecture, specially when it
> comes to PM support which currently we have
> working for at least OMAP3 and we'd like
> to know about any changes being made to our
> PMICs and IRQ controllers.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---

I wonder if we should list file-by-file since some of hte tps devices
are rather used by NVidia and other SoCs.

If you prefer, I'll go grep around on our DTS files and list one-by-one,
no issues.

>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3c64271..4fc2a2c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6594,6 +6594,16 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>  S:	Maintained
>  F:	arch/arm/*omap*/
>  F:	drivers/i2c/busses/i2c-omap.c
> +F:	drivers/irqchip/irq-omap-intc.c
> +F:	drivers/mfd/*omap*.c
> +F:	drivers/mfd/menelaus.c
> +F:	drivers/mfd/palmas.c
> +F:	drivers/mfd/tps6*.c
> +F:	drivers/mfd/twl4030*.c
> +F:	drivers/regulator/palmas-regulator*.c
> +F:	drivers/regulator/pbias-regulator.c
> +F:	drivers/regulator/tps6*.c
> +F:	drivers/regulator/twl*.c
>  F:	include/linux/i2c-omap.h
>  
>  OMAP DEVICE TREE SUPPORT
> -- 
> 2.1.0.GIT
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/cdf95dcb/attachment.sig>
