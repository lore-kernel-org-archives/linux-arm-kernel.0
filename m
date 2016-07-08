From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Fri, 8 Jul 2016 03:05:41 +0000
Subject: [PATCH 2/4] soc: fsl: add GUTS driver for QorIQ platforms
In-Reply-To: <4094106.qfxJu3tJbO@wuerfel>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <1465609853.22191.151.camel@buserror.net>
 <HE1PR04MB0889646206BFAD68046F3473F83B0@HE1PR04MB0889.eurprd04.prod.outlook.com>
 <4094106.qfxJu3tJbO@wuerfel>
Message-ID: <HE1PR04MB0889950E99B791029F1670E9F83C0@HE1PR04MB0889.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, July 07, 2016 4:30 PM
> To: Yangbo Lu
> Cc: Scott Wood; linuxppc-dev at lists.ozlabs.org; Mark Rutland; Ulf Hansson;
> linux-kernel at vger.kernel.org; linux-i2c at vger.kernel.org; linux-
> clk at vger.kernel.org; Qiang Zhao; Russell King; Bhupesh Sharma; Joerg
> Roedel; Claudiu Manoil; devicetree at vger.kernel.org; Kumar Gala; Rob
> Herring; Santosh Shilimkar; linux-arm-kernel at lists.infradead.org;
> netdev at vger.kernel.org; linux-mmc at vger.kernel.org; Xiaobo Xie; Yang-Leo
> Li; iommu at lists.linux-foundation.org
> Subject: Re: [PATCH 2/4] soc: fsl: add GUTS driver for QorIQ platforms
> 
> On Thursday, July 7, 2016 2:35:33 AM CEST Yangbo Lu wrote:
> > Hi Arnd,
> >
> > Could you reply when you see the email?
> > If your method doesn?t resolve the problem, we still want to use our
> old patchset.
> >
> > This guts driver had been discussed about one year and blocked many
> workaround upstream.
> > So please help to review and comment soon.
> >
> 
> I don't really see how more discussion is going to help us here. I think
> I've made it pretty clear that I don't want to see another platform
> specific way to read an SoC revision and I've even sent a proof-of-
> concept patch to show how the interface can work, now it's up to you to
> fit the guts hardware into that and send a new patch series.
> 
> 	Arnd

I think your proof-of-concept patch is still in discussion. Some answers are needed from you to
address Scott's comments on your patchset. Have you reached an agreement?

Thanks.

- Yangbo Lu
