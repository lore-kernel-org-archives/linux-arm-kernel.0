From: dinguyen@altera.com (Dinh Nguyen)
Date: Fri, 25 Jan 2013 10:21:10 -0600
Subject: [PATCHv1 for soc 3/5] arm: socfpga: Add entries to enable make
 dtbs socfpga
In-Reply-To: <20130125151357.GC10055@amd.pavel.ucw.cz>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-4-git-send-email-dinguyen@altera.com>
 <20130125151357.GC10055@amd.pavel.ucw.cz>
Message-ID: <1359130870.32148.6.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Fri, 2013-01-25 at 16:13 +0100, Pavel Machek wrote:
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -124,6 +124,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
> >  	r8a7740-armadillo800eva.dtb \
> >  	sh73a0-kzm9g.dtb \
> >  	sh7372-mackerel.dtb
> > +dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
> > +	socfpga_vt.dtb
> >  dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
> >  	spear1340-evb.dtb
> >  dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
> 
> This allows me to remove manual dtb invocation from the build
> scripts. Good.
> 
> For 2,3/5:
> 
> Tested-by: Pavel Machek <pavel@denx.de>
> Reviewed-by: Pavel Machek <pavel@denx.de>

Thanks,
Dinh
> 
> 									Pavel
