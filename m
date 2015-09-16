From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 16 Sep 2015 11:36:07 -0700
Subject: [PATCH 5/6] pinctrl: mediatek: Remove unneded semicolon
In-Reply-To: <1442392111-8448-6-git-send-email-javier@osg.samsung.com>
References: <1442392111-8448-1-git-send-email-javier@osg.samsung.com>
 <1442392111-8448-6-git-send-email-javier@osg.samsung.com>
Message-ID: <1442428567.39832.1.camel@mussux00.eus.mediatek.inc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-09-16 at 10:28 +0200, Javier Martinez Canillas wrote:
> It's not needed an is just creating a null statement, so remove it.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 7726c6caaf83..652ec125adb3 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -1436,7 +1436,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
>  		irq_set_chip_and_handler(virq, &mtk_pinctrl_irq_chip,
>  			handle_level_irq);
>  		irq_set_chip_data(virq, pctl);
> -	};
> +	}
>  
>  	irq_set_chained_handler_and_data(irq, mtk_eint_irq_handler, pctl);
>  	return 0;


Acked-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Thanks
Hongzhou
