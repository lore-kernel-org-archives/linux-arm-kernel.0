From: Haibo.Chen@freescale.com (Chen Bough)
Date: Fri, 28 Aug 2015 06:53:36 +0000
Subject: [PATCH v6 0/6] mmc: imx: a few fixes and new feature
In-Reply-To: <CAPDyKFriWeJTsymd+Ha0ZY+UWjpbEdKMwZgw1hA2zZhw5khPaw@mail.gmail.com>
References: <1439293111-21077-1-git-send-email-haibo.chen@freescale.com>
 <CAPDyKFriWeJTsymd+Ha0ZY+UWjpbEdKMwZgw1hA2zZhw5khPaw@mail.gmail.com>
Message-ID: <BY1PR03MB1388F0A45EF1A6CC38D2A4489A6E0@BY1PR03MB1388.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks? Uffe.


Hi Shawn and Sascha,

Can you help pull the patch4 in your branch? 


Best Regards
Haibo Chen


> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson at linaro.org]
> Sent: Tuesday, August 25, 2015 8:06 PM
> To: Chen Haibo-B51421
> Cc: Rob Herring; Pawe? Moll; Mark Rutland; Ian Campbell; Kumar Gala;
> Shawn Guo; Sascha Hauer; Russell King - ARM Linux; Dong Aisheng-B29396;
> Johan Derycke; Marc Kleine-Budde; Estevam Fabio-R49496;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-mmc
> Subject: Re: [PATCH v6 0/6] mmc: imx: a few fixes and new feature
> 
> On 11 August 2015 at 13:38, Haibo Chen <haibo.chen@freescale.com> wrote:
> > Changes for v6:
> > -remove duplicate code in esdhc_set_uhs_signaling().
> > -fix a typo for patch-2.
> > -make commit log of patch-3 more specific.
> >
> > Haibo Chen (6):
> >   mmc: sdhci-esdhc-imx: add imx7d support and support HS400
> >   mmc: sdhci-esdhc-imx: add tuning-step setting support
> >   mmc: sdhci-esdhc-imx: add imx7d support in bingding doc
> >   ARM: dts: imx7d-sdb: add eMMC5.0 support
> >   mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1
> >   mmc: sdhci-esdhc-imx: change default watermark level and burst
> > length
> >
> >  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   6 ++
> >  arch/arm/boot/dts/imx7d-sdb.dts                    |  13 +++
> >  drivers/mmc/host/sdhci-esdhc-imx.c                 | 114
> ++++++++++++++++++++-
> >  include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
> >  4 files changed, 130 insertions(+), 4 deletions(-)
> >
> > --
> > 1.9.1
> >
> 
> I have applied this for next - except patch4 as it needs and ack from the
> IMX SOC maintainer, or it may be better to take that patch through ARM
> soc...
> 
> Regarding patch3, which document the new bindings and the compatible
> string, I moved this to be the first patch and fixed the spelling of the
> commit message header.
> 
> Thanks!
> 
> Kind regards
> Uffe
