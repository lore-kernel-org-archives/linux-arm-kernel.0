From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Tue, 26 Apr 2016 03:12:30 +0000
Subject: [v8, 6/7] MAINTAINERS: add entry for Freescale SoC specific driver
In-Reply-To: <1461367352.32510.218.camel@buserror.net>
References: <1461306464-19521-1-git-send-email-yangbo.lu@nxp.com>
 <1461306464-19521-7-git-send-email-yangbo.lu@nxp.com>
 <1461367352.32510.218.camel@buserror.net>
Message-ID: <HE1PR04MB088907CD90586FC83D058003F8630@HE1PR04MB0889.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott and Leo,


> -----Original Message-----
> From: linux-mmc-owner at vger.kernel.org [mailto:linux-mmc-
> owner at vger.kernel.org] On Behalf Of Scott Wood
> Sent: Saturday, April 23, 2016 7:23 AM
> To: Yangbo Lu; linux-mmc at vger.kernel.org; linuxppc-dev at lists.ozlabs.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Cc: ulf.hansson at linaro.org; Zhao Qiang; Russell King; Bhupesh Sharma;
> Scott Wood; Claudiu Manoil; Kumar Gala; Yang-Leo Li; Xiaobo Xie; Michael
> Ellerman
> Subject: Re: [v8, 6/7] MAINTAINERS: add entry for Freescale SoC specific
> driver
> 
> On Fri, 2016-04-22 at 14:27 +0800, Yangbo Lu wrote:
> > Add maintainer entry for Freescale SoC specific driver including the
> > QE library and the GUTS driver. Also add entry for GUTS driver and add
> > maintainer for QE library.
> >
> > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > ---
> > Changes for v8:
> > 	- Added this patch
> > ---
> >  MAINTAINERS | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index 1d5b4be..d20aeb6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4622,13 +4622,27 @@ F:	drivers/net/ethernet/freescale/fec_ptp.c
> >  F:	drivers/net/ethernet/freescale/fec.h
> >  F:	Documentation/devicetree/bindings/net/fsl-fec.txt
> >
> > +FREESCALE SOC SPECIFIC DRIVER
> 
> FREESCALE SOC DRIVERS

[Lu Yangbo-B47093] Ok, will change it to 'FREESCALE SOC DRIVERS'.

> 
> > +M:	Scott Wood <oss@buserror.net>
> 
> Please CC me at this address, not the NXP address that you sent this to...

[Lu Yangbo-B47093] Sorry for mistaking your email. Will send the one you said.

> 
> > +L:	linuxppc-dev at lists.ozlabs.org
> > +S:	Maintained
> > +F:	drivers/soc/fsl/
> > +F:	include/linux/fsl/
> 
> This directory will contain drivers that work on PPC and ARM... I'm not
> sure what to put here in terms of mailing lists (we could put both, but
> people probably shouldn't spam both lists if only one arch is relevant to
> the patch), and whom to make pull requests to.

[Lu Yangbo-B47093] But sooner or later we need to do this for files in fsl/ ...
:)

Hi Leo, do you have any idea?


> 
> > +FREESCALE GUTS DRIVER
> > +M:	Yangbo Lu <yangbo.lu@nxp.com>
> > +L:	linuxppc-dev at lists.ozlabs.org
> > +S:	Maintained
> > +F:	drivers/soc/fsl/guts.c
> 
> What about the header?
> 
> Does guts really need a separate maintainer from drivers/soc/fsl?

[Lu Yangbo-B47093] I was hesitating to add the maintainer...
And I was not so familiar with it. Let me leave it to the fsl/ directory and remove this...

> 
> -Scott
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
