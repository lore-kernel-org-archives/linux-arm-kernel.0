From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 10 Oct 2017 15:35:51 +0800
Subject: [PATCH v3 01/12] mmc: mediatek: add support of mt2701/mt2712
In-Reply-To: <CAPDyKFrqv5tt8Exq1msUBbMEROam2c+YnStazsf5SPj-NLrGSg@mail.gmail.com>
References: <1507604480-23246-1-git-send-email-chaotian.jing@mediatek.com>
 <1507604480-23246-2-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFrqv5tt8Exq1msUBbMEROam2c+YnStazsf5SPj-NLrGSg@mail.gmail.com>
Message-ID: <1507620951.19789.7.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-10 at 09:26 +0200, Ulf Hansson wrote:
> [...]
> 
> > +
> > +static const struct of_device_id msdc_of_ids[] = {
> > +       { .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
> > +       { .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
> > +       { .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
> > +       { .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, msdc_of_ids);
> 
> As already stated in the other reply. These new compatible changes
> needs to be discussed and acked before the driver starts using them.
> 
> In other words, make patch3 to precede this one.
but, then there will have a probe issue as mentioned in previous mail
list. that's why I separate the binding file changes to 2 patches.
> 
> [...]
> 
> Kind regards
> Uffe
