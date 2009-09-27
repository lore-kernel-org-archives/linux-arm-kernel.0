From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1_=27Sleep=5FWalker=27?=
	=?utf-8?q?_=C4=8Cech?=)
Date: Sun, 27 Sep 2009 02:22:41 +0200
Subject: [PATCH V2] MAINTAINERS: ARM/Palm file patterns
In-Reply-To: <1254002818.7128.65.camel@Joe-Laptop.home>
References: <1253990824.7128.25.camel@Joe-Laptop.home>
	<200909262230.43385.marek.vasut@gmail.com>
	<1254002818.7128.65.camel@Joe-Laptop.home>
Message-ID: <200909270222.42029.sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne Ne 27. z??? 2009 00:06:58 Joe Perches napsal(a):
> On Sat, 2009-09-26 at 22:30 +0200, Marek Vasut wrote:
> > Dne So 26. z??? 2009 21:53:52 Joe Perches napsal(a):
> > > On Sat, 2009-09-26 at 21:14 +0200, Marek Vasut wrote:
> > > > This might cause trouble, we're working on renaming treo680 (as below) to
> > > > palmtreo so palm* wont do ... you'll possibly have to list them or
> > > > something. Otherwise ok.
> > palmasoc will hopefully go to hell soon anyway. Otherwise, I'm for the second 
> > method (listing the files, one per line), it's least confusing.

Acked-by: Tomas Cech <sleep_walker@suse.cz>

> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c450f3a..f8f9c4f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -741,23 +741,36 @@ M:	Dirk Opfer <dirk@opfer-online.de>
>  S:	Maintained
>  
>  ARM/PALMTX,PALMT5,PALMLD,PALMTE2,PALMTC SUPPORT
> -P:	Marek Vasut
> -M:	marek.vasut at gmail.com
> +M:	Marek Vasut <marek.vasut@gmail.com>
>  L:	linux-arm-kernel at lists.infradead.org
>  W:	http://hackndev.com
>  S:	Maintained
> +F:	arch/arm/mach-pxa/include/mach/palmtx.h
> +F:	arch/arm/mach-pxa/palmtx.c
> +F:	arch/arm/mach-pxa/include/mach/palmt5.h
> +F:	arch/arm/mach-pxa/palmt5.c
> +F:	arch/arm/mach-pxa/include/mach/palmld.h
> +F:	arch/arm/mach-pxa/palmld.c
> +F:	arch/arm/mach-pxa/include/mach/palmte2.h
> +F:	arch/arm/mach-pxa/palmte2.c
> +F:	arch/arm/mach-pxa/include/mach/palmtc.h
> +F:	arch/arm/mach-pxa/palmtc.c
>  
>  ARM/PALM TREO 680 SUPPORT
>  M:	Tomas Cech <sleep_walker@suse.cz>
>  L:	linux-arm-kernel at lists.infradead.org
>  W:	http://hackndev.com
>  S:	Maintained
> +F:	arch/arm/mach-pxa/include/mach/treo680.h
> +F:	arch/arm/mach-pxa/treo680.c
>  
>  ARM/PALMZ72 SUPPORT
>  M:	Sergey Lapin <slapin@ossfans.org>
>  L:	linux-arm-kernel at lists.infradead.org
>  W:	http://hackndev.com
>  S:	Maintained
> +F:	arch/arm/mach-pxa/include/mach/palmz72.h
> +F:	arch/arm/mach-pxa/palmz72.c
>  
>  ARM/PLEB SUPPORT
>  M:	Peter Chubb <pleb@gelato.unsw.edu.au>
> 

Best regards,

Tomas Cech
