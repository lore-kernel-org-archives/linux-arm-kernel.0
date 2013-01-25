From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 25 Jan 2013 16:13:58 +0100
Subject: [PATCHv1 for soc 3/5] arm: socfpga: Add entries to enable make
 dtbs socfpga
In-Reply-To: <1359075633-13502-4-git-send-email-dinguyen@altera.com>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-4-git-send-email-dinguyen@altera.com>
Message-ID: <20130125151357.GC10055@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -124,6 +124,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
>  	r8a7740-armadillo800eva.dtb \
>  	sh73a0-kzm9g.dtb \
>  	sh7372-mackerel.dtb
> +dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
> +	socfpga_vt.dtb
>  dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
>  	spear1340-evb.dtb
>  dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \

This allows me to remove manual dtb invocation from the build
scripts. Good.

For 2,3/5:

Tested-by: Pavel Machek <pavel@denx.de>
Reviewed-by: Pavel Machek <pavel@denx.de>

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
