From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 1 Jul 2017 10:21:13 +0100
Subject: [PATCH v2 3/3] iio: adc: mt7622: Add compatible node for mt7622.
In-Reply-To: <1498457502-3669-4-git-send-email-zhiyong.tao@mediatek.com>
References: <1498457502-3669-1-git-send-email-zhiyong.tao@mediatek.com>
 <1498457502-3669-4-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <20170701102113.2f53742c@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Jun 2017 14:11:42 +0800
Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> This commit adds mt7622 compatible node.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/mt6577_auxadc.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index c174b73..4224fc0 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -308,6 +308,7 @@ static SIMPLE_DEV_PM_OPS(mt6577_auxadc_pm_ops,
>  
>  static const struct of_device_id mt6577_auxadc_of_match[] = {
>  	{ .compatible = "mediatek,mt2701-auxadc", },
> +	{ .compatible = "mediatek,mt7622-auxadc", },
>  	{ .compatible = "mediatek,mt8173-auxadc", },
>  	{ }
>  };
