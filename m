From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 26 Sep 2009 21:14:08 +0200
Subject: [PATCH] MAINTAINERS: ARM/Palm file patterns
In-Reply-To: <1253990824.7128.25.camel@Joe-Laptop.home>
References: <1253990824.7128.25.camel@Joe-Laptop.home>
Message-ID: <200909262114.08994.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 26. z??? 2009 20:47:04 Joe Perches napsal(a):
> Hi Marek.

Hi!
sorry I missed your last mail.
> 
> For the section you maintain, are these file patterns correct?
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c450f3a..f91ac61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -741,11 +741,12 @@ M:	Dirk Opfer <dirk@opfer-online.de>
>  S:	Maintained
> 
>  ARM/PALMTX,PALMT5,PALMLD,PALMTE2,PALMTC SUPPORT
> -P:	Marek Vasut
> -M:	marek.vasut at gmail.com
> +M:	Marek Vasut <marek.vasut@gmail.com>
>  L:	linux-arm-kernel at lists.infradead.org
>  W:	http://hackndev.com
>  S:	Maintained
> +F:	arch/arm/mach-pxa/include/mach/palm*
> +F:	arch/arm/mach-pxa/palm*

This might cause trouble, we're working on renaming treo680 (as below) to 
palmtreo so palm* wont do ... you'll possibly have to list them or something. 
Otherwise ok.

Cheers!
> 
>  ARM/PALM TREO 680 SUPPORT
>  M:	Tomas Cech <sleep_walker@suse.cz>
> 
