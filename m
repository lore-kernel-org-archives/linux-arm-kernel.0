From: zhiyong.tao@mediatek.com (zhiyong tao)
Date: Mon, 26 Jun 2017 09:55:39 +0800
Subject: [PATCH 3/3] iio: adc: mt7622: Add compatible node for mt7622.
In-Reply-To: <20170624210213.5e552e5c@kernel.org>
References: <1498110274-18678-1-git-send-email-zhiyong.tao@mediatek.com>
 <1498110274-18678-4-git-send-email-zhiyong.tao@mediatek.com>
 <20170624210213.5e552e5c@kernel.org>
Message-ID: <1498442139.536.4.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-06-24 at 21:02 +0100, Jonathan Cameron wrote:
> On Thu, 22 Jun 2017 13:44:34 +0800
> Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
> 
> > This commit adds mt7622 compatible node.
> > 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > ---
> >  drivers/iio/adc/mt6577_auxadc.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> > index 2dd7c74..4a2cd9e 100644
> > --- a/drivers/iio/adc/mt6577_auxadc.c
> > +++ b/drivers/iio/adc/mt6577_auxadc.c
> > @@ -308,6 +308,7 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
> >  static const struct of_device_id mt6577_auxadc_of_match[] = {
> >  	{ .compatible = "mediatek,mt2701-auxadc", },
> >  	{ .compatible = "mediatek,mt8173-auxadc", },
> > +	{ .compatible = "mediatek,mt7622-auxadc", },
> Keep them in numeric order perhaps?
> 
> Might become a worthwhile step if this logic gets used for lot more parts in future!
> 
> Jonathan

==>Ok, we will change them in numeric order perhaps in v2.
Thanks.

> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, mt6577_auxadc_of_match);
> 
