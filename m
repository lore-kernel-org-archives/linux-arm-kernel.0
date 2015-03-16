From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 16:19:35 -0700
Subject: [PATCH v2] MAINTAINERS: add OMAP defconfigs under OMAP SUPPORT
In-Reply-To: <1421705633-29056-1-git-send-email-balbi@ti.com>
References: <1421705633-29056-1-git-send-email-balbi@ti.com>
Message-ID: <20150316231934.GW12397@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150119 14:18]:
> omap2plus_defconfig and omap1_defconfig are also
> part of the OMAP Support maintained, because of
> that it's best to list them under OMAP SUPPORT on
> MAINTAINERS so people know to Cc linux-omap when
> patching them.
> 
> Reported-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applying into omap-for-v4.1/fixes-not-urgent thanks.

Tony

> ---
> 
> Add omap1_defconfig too
> 
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97de006f38f0..7423e9759187 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6783,6 +6783,8 @@ Q:	http://patchwork.kernel.org/project/linux-omap/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>  S:	Maintained
>  F:	arch/arm/*omap*/
> +F:	arch/arm/configs/omap1_defconfig
> +F:	arch/arm/configs/omap2plus_defconfig
>  F:	drivers/i2c/busses/i2c-omap.c
>  F:	drivers/irqchip/irq-omap-intc.c
>  F:	drivers/mfd/*omap*.c
> -- 
> 2.2.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
