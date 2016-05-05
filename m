From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Thu, 5 May 2016 03:21:04 +0000
Subject: [v9, 6/7] MAINTAINERS: add entry for Freescale SoC driver
In-Reply-To: <1462383308.16584.43.camel@buserror.net>
References: <1462332274-13744-1-git-send-email-yangbo.lu@nxp.com>
 <1462332274-13744-7-git-send-email-yangbo.lu@nxp.com>
 <1462383308.16584.43.camel@buserror.net>
Message-ID: <HE1PR04MB0889AA66ABC718111D7EF41FF87C0@HE1PR04MB0889.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks a lot, Scott and Qiang.
Will change 'DRIVER' to 'DRIVERS' and update the patchset with your acts.


Best regards,
Yangbo Lu

> -----Original Message-----
> From: linux-mmc-owner at vger.kernel.org [mailto:linux-mmc-
> owner at vger.kernel.org] On Behalf Of Scott Wood
> Sent: Thursday, May 05, 2016 1:35 AM
> To: Yangbo Lu; linux-mmc at vger.kernel.org; linuxppc-dev at lists.ozlabs.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; linux-clk at vger.kernel.org; linux-
> i2c at vger.kernel.org; iommu at lists.linux-foundation.org;
> netdev at vger.kernel.org
> Cc: ulf.hansson at linaro.org; Mark Rutland; Rob Herring; Russell King;
> Jochen Friedrich; Joerg Roedel; Claudiu Manoil; Bhupesh Sharma; Qiang
> Zhao; Kumar Gala; Santosh Shilimkar; Yang-Leo Li; Xiaobo Xie
> Subject: Re: [v9, 6/7] MAINTAINERS: add entry for Freescale SoC driver
> 
> On Wed, 2016-05-04 at 11:24 +0800, Yangbo Lu wrote:
> > Add maintainer entry for Freescale SoC driver including the QE library
> > and the GUTS driver now. Also add maintainer for QE library.
> >
> > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > ---
> > Changes for v8:
> > 	- Added this patch
> > Changes for v9:
> > 	- Added linux-arm mail list
> > 	- Removed GUTS driver entry
> > ---
> >  MAINTAINERS | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index 42e65d1..ce91db7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4622,9 +4622,18 @@ F:	drivers/net/ethernet/freescale/fec_ptp.c
> >  F:	drivers/net/ethernet/freescale/fec.h
> >  F:	Documentation/devicetree/bindings/net/fsl-fec.txt
> >
> > +FREESCALE SOC DRIVER
> > +M:	Scott Wood <oss@buserror.net>
> > +L:	linuxppc-dev at lists.ozlabs.org
> > +L:	linux-arm-kernel at lists.infradead.org
> > +S:	Maintained
> > +F:	drivers/soc/fsl/
> > +F:	include/linux/fsl/
> > +
> >  FREESCALE QUICC ENGINE LIBRARY
> > +M:	Qiang Zhao <qiang.zhao@nxp.com>
> >  L:	linuxppc-dev at lists.ozlabs.org
> > -S:	Orphan
> > +S:	Maintained
> >  F:	drivers/soc/fsl/qe/
> >  F:	include/soc/fsl/*qe*.h
> >  F:	include/soc/fsl/*ucc*.h
> 
> s/DRIVER/DRIVERS/
> 
> There's more than one.
> 
> Otherwise:
> Acked-by: Scott Wood <oss@buserror.net>
> 
> -Scott
> 
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
