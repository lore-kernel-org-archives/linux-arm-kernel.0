From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 24 Sep 2017 16:46:08 +0100
Subject: [PATCH 2/3] iio: adc: mt2712: Add compatible node for mt2712.
In-Reply-To: <1505957212-13402-3-git-send-email-zhiyong.tao@mediatek.com>
References: <1505957212-13402-1-git-send-email-zhiyong.tao@mediatek.com>
 <1505957212-13402-3-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <20170924164608.0a2b01a6@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Sep 2017 09:26:51 +0800
Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> This commit adds mt2712 compatible node.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  drivers/iio/adc/mt6577_auxadc.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 414cf44..70bfa1e 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -306,6 +306,7 @@ static SIMPLE_DEV_PM_OPS(mt6577_auxadc_pm_ops,
>  
>  static const struct of_device_id mt6577_auxadc_of_match[] = {
>  	{ .compatible = "mediatek,mt2701-auxadc", },
> +	{ .compatible = "mediatek,mt2712-auxadc", },
>  	{ .compatible = "mediatek,mt7622-auxadc", },
>  	{ .compatible = "mediatek,mt8173-auxadc", },
>  	{ }
