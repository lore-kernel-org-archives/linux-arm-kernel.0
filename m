From: blogic@openwrt.org (John Crispin)
Date: Thu, 25 Feb 2016 16:34:39 +0100
Subject: [PATCH] pinctrl: mediatek/7623: delete unnecessary .owner
In-Reply-To: <1456413981-26089-1-git-send-email-linus.walleij@linaro.org>
References: <1456413981-26089-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <56CF1F0F.1060407@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/02/2016 16:26, Linus Walleij wrote:
> This is set by the device core.
> 
> Cc: John Crispin <blogic@openwrt.org>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, i was just going to send it to you and then i saw you and feng
had already sent me a version, 2 is already more than needed so i wont
spin up a 3rd version ;)

can you fold this please ?

> ---
>  drivers/pinctrl/mediatek/pinctrl-mt7623.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7623.c b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
> index bf0d05b6e7dc..67895f8234e3 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt7623.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
> @@ -367,7 +367,6 @@ static struct platform_driver mtk_pinctrl_driver = {
>  	.probe = mt7623_pinctrl_probe,
>  	.driver = {
>  		.name = "mediatek-mt7623-pinctrl",
> -		.owner = THIS_MODULE,
>  		.of_match_table = mt7623_pctrl_match,
>  	},
>  };
> 
