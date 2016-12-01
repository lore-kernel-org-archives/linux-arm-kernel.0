From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 30 Nov 2016 16:45:57 -0800
Subject: [RESEND PATCH] pinctrl: mt8173: set GPIO16 to usb iddig mode
In-Reply-To: <1480472491-4644-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1480472491-4644-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1480553157.29122.8.camel@mussux00>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-11-30 at 10:21 +0800, Chunfeng Yun wrote:
> the default mode of GPIO16 pin is gpio, when set EINT16 to
> IRQ_TYPE_LEVEL_HIGH, no interrupt is triggered, it can be
> fixed when set its default mode as usb iddig.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
> index 13e5b68..9b018fd 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
> @@ -201,7 +201,7 @@
>  	MTK_PIN(
>  		PINCTRL_PIN(16, "IDDIG"),
>  		NULL, "mt8173",
> -		MTK_EINT_FUNCTION(0, 16),
> +		MTK_EINT_FUNCTION(1, 16),
>  		MTK_FUNCTION(0, "GPIO16"),
>  		MTK_FUNCTION(1, "IDDIG"),
>  		MTK_FUNCTION(2, "CMFLASH"),

Acked-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Thanks,
Hongzhou
