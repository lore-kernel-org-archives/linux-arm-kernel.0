From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Fri, 25 Mar 2016 06:44:33 +0000
Subject: [v6, 2/5] soc: fsl: add GUTS driver for QorIQ platforms
In-Reply-To: <DB5PR0401MB1928302BB0DDE8D9B47E4361918C0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-3-git-send-email-yangbo.lu@nxp.com>
 <DB5PR0401MB1928302BB0DDE8D9B47E4361918C0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Message-ID: <HE1PR04MB0889420582187F850129D3D0F8830@HE1PR04MB0889.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Scott Wood
> Sent: Saturday, March 19, 2016 6:55 AM
> To: Yangbo Lu; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linuxppc-
> dev at lists.ozlabs.org; linux-clk at vger.kernel.org; linux-
> i2c at vger.kernel.org; iommu at lists.linux-foundation.org;
> netdev at vger.kernel.org; linux-mmc at vger.kernel.org
> Cc: Rob Herring; Russell King; Jochen Friedrich; Joerg Roedel; Claudiu
> Manoil; ulf.hansson at linaro.org; Bhupesh Sharma; Zhao Qiang; Kumar Gala;
> Santosh Shilimkar; Yang-Leo Li; Xiaobo Xie
> Subject: Re: [v6, 2/5] soc: fsl: add GUTS driver for QorIQ platforms
> 
> On 03/09/2016 04:18 AM, Yangbo Lu wrote:
> > +#ifdef CONFIG_FSL_GUTS
> > +u32 fsl_guts_get_svr(void);
> > +int fsl_guts_init(void);
> > +#endif
> 
> Don't ifdef prototypes (when not providing a stub alternative).
> 
> -Scott

[Lu Yangbo-B47093] Ok, will remove the ifdef.
Thank you very much.
