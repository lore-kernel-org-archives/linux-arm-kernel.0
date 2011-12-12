From: joe@perches.com (Joe Perches)
Date: Mon, 12 Dec 2011 14:28:28 -0800
Subject: [PATCH 4/5] MAINTAINERS: add maintainer entry for Picochip
 picoxcell
In-Reply-To: <1323726414-3319-5-git-send-email-jamie@jamieiles.com>
References: <1323726414-3319-1-git-send-email-jamie@jamieiles.com>
 <1323726414-3319-5-git-send-email-jamie@jamieiles.com>
Message-ID: <1323728908.1812.5.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-12-12 at 21:46 +0000, Jamie Iles wrote:
> Add maintainer entry for the picoxcell machine support and associated
> drivers.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -5114,6 +5114,14 @@ L:	linux-mtd at lists.infradead.org
>  S:	Maintained
>  F:	drivers/mtd/devices/phram.c
>  
> +PICOXCELL SUPPORT
> +M:	Jamie Iles <jamie@jamieiles.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +T:	git git://github.com/jamieiles/linux-2.6-ji.git
> +S:	Supported
> +F:	arch/arm/mach-picoxcell
> +F:	drivers/*/picoxcell*

This wildcard matches only 1 directory depth level.

To match "drivers/char/hw_random/picoxcell-rng.c"
you also need to have:

F:	drivers/*/*/picoxcell*
