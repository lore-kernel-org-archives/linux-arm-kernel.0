From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 25 May 2011 10:10:19 +0200
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <201105181047.17309.arnd@arndb.de>
References: <201105181047.17309.arnd@arndb.de>
Message-ID: <4DDCB96B.5000606@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/05/2011 10:47, Arnd Bergmann :
> This is the draft plan for maintaining the ARM subarchitectures in a common
> tree, as a way to help coordinate the upstream merging of the
> arch/arm/{plat,mach}-* changes into Linus' tree.

[..]

> Maintainers: If you are happy with the layout of the process,
> please ack this patch, otherwise please comment.
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8fce5e6..942d052 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -630,6 +630,17 @@ S:	Maintained
>  F:	drivers/amba/
>  F:	include/linux/amba/bus.h
>  
> +ARM SUBARCHITECTURES
> +M:	Arnd Bergmann <arnd@arndb.de>
> +M:	Nicolas Pitre <nico@fluxnic.net>
> +M:	Thomas Gleixner <tglx@linutronix.de>
> +M:	arm at kernel.org

New alias needed?

> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	MAINTAINED
> +F:	arch/arm/mach-*/
> +F:	arch/arm/plat-*/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-subarch.git

I like this initiative. Thanks to you guys for this effort!

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
(as co-maintainer of the Atmel AT91 subarchitecture)

Bye,
-- 
Nicolas Ferre
