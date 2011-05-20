From: joe@perches.com (Joe Perches)
Date: Fri, 20 May 2011 13:59:45 -0700
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <201105181047.17309.arnd@arndb.de>
References: <201105181047.17309.arnd@arndb.de>
Message-ID: <1305925185.4209.86.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-18 at 10:47 +0200, Arnd Bergmann wrote:
> otherwise please comment.
> diff --git a/MAINTAINERS b/MAINTAINERS
> @@ -630,6 +630,17 @@ S:	Maintained
>  F:	drivers/amba/
>  F:	include/linux/amba/bus.h
>  
> +ARM SUBARCHITECTURES
> +M:	Arnd Bergmann <arnd@arndb.de>
> +M:	Nicolas Pitre <nico@fluxnic.net>
> +M:	Thomas Gleixner <tglx@linutronix.de>
> +M:	arm at kernel.org
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	MAINTAINED

Trivial.  Please use:

S:	Maintained
