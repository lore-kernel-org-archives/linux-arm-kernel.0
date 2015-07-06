From: Haibo.Chen@freescale.com (Chen Bough)
Date: Mon, 6 Jul 2015 03:05:47 +0000
Subject: [PATCH 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting support
In-Reply-To: <20150703111017.GA17553@localhost>
References: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
 <1433926244-29244-3-git-send-email-haibo.chen@freescale.com>
 <20150703111017.GA17553@localhost>
Message-ID: <BY1PR03MB138801E1ECE136F138F7D4A99A930@BY1PR03MB1388.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Friday, July 03, 2015 7:10 PM
> To: Chen Haibo-B51421
> Cc: linux-mmc at vger.kernel.org; Dong Aisheng-B29396;
> ulf.hansson at linaro.org; chris at printf.net; shawn.guo at linaro.org; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting
> support
> 
> On Wed, Jun 10, 2015 at 04:50:40PM +0800, Haibo Chen wrote:
> > @@ -969,6 +976,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device
> *pdev,
> >
> >  	of_property_read_u32(np, "max-frequency", &boarddata->f_max);
> >
> > +	of_property_read_u32(np, "tuning-step", &boarddata->tuning_step);
> > +
> 
> Where is the binding doc for this device tree property?
> 
> Shawn

I will add this in next version, Thanks for your review.


Haibo
