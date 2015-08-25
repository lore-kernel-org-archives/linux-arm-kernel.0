From: haibo.chen@freescale.com (Haibo Chen)
Date: Tue, 25 Aug 2015 11:34:19 +0800
Subject: [PATCH v6 0/6] mmc: imx: a few fixes and new feature
In-Reply-To: <20150813085854.GA19166@shlinux1.ap.freescale.net>
References: <1439293111-21077-1-git-send-email-haibo.chen@freescale.com>
 <20150813085854.GA19166@shlinux1.ap.freescale.net>
Message-ID: <20150825033418.GA15468@b51421-server.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 04:58:56PM +0800, Dong Aisheng wrote:
> On Tue, Aug 11, 2015 at 07:38:25PM +0800, Haibo Chen wrote:
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
> >   mmc: sdhci-esdhc-imx: change default watermark level and burst length
> > 
> >  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   6 ++
> >  arch/arm/boot/dts/imx7d-sdb.dts                    |  13 +++
> >  drivers/mmc/host/sdhci-esdhc-imx.c                 | 114 ++++++++++++++++++++-
> >  include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
> >  4 files changed, 130 insertions(+), 4 deletions(-)
> > 
> > -- 
> > 1.9.1
> > 
> 
> The patch set looks good to me.
> 
> Acked-by: Dong Aisheng <aisheng.dong@freescale.com>
> 
> Regards
> Dong Aisheng

Hi Ulf,

Can you help pull these patches into your branch?


Best regards

Haibo
-- 
