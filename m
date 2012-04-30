From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 30 Apr 2012 13:48:28 -0400
Subject: [PATCH] maintainership update for the Marvell Orion family of SOCs
In-Reply-To: <alpine.LFD.2.02.1204301330111.21030@xanadu.home>
References: <alpine.LFD.2.02.1204301330111.21030@xanadu.home>
Message-ID: <20120430174828.GZ15711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 01:44:48PM -0400, Nicolas Pitre wrote:
> While Lennert and I have moved our focus to other things, some people
> picked up the slack on those platforms.  Let's empower them with a more 
> official status.
> 
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>

Acked-by: Jason Cooper <jason@lakedaemon.net>

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bb76fc42fc..348b881f74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -908,11 +908,12 @@ ARM/MAGICIAN MACHINE SUPPORT
>  M:	Philipp Zabel <philipp.zabel@gmail.com>
>  S:	Maintained
>  
> -ARM/Marvell Loki/Kirkwood/MV78xx0/Orion SOC support
> -M:	Lennert Buytenhek <kernel@wantstofly.org>
> -M:	Nicolas Pitre <nico@fluxnic.net>
> +ARM/Marvell Dove/Kirkwood/MV78xx0/Orion SOC support
> +M:	Jason Cooper <jason@lakedaemon.net>
> +M:	Andrew Lunn <andrew@lunn.ch>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> -S:	Odd Fixes
> +S:	Maintained
> +F:	arch/arm/mach-dove/
>  F:	arch/arm/mach-kirkwood/
>  F:	arch/arm/mach-mv78xx0/
>  F:	arch/arm/mach-orion5x/
