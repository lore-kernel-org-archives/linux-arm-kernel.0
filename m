From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 24 Aug 2016 14:26:58 +0200
Subject: [PATCH 1/2] reset: uniphier: add static qualifier to probe
 function
In-Reply-To: <1472020830-16059-2-git-send-email-yamada.masahiro@socionext.com>
References: <1472020830-16059-1-git-send-email-yamada.masahiro@socionext.com>
 <1472020830-16059-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1472041618.5335.31.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 24.08.2016, 15:40 +0900 schrieb Masahiro Yamada:
> I missed this in the initial commit.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/reset/reset-uniphier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
> index 9de071f..41c62af 100644
> --- a/drivers/reset/reset-uniphier.c
> +++ b/drivers/reset/reset-uniphier.c
> @@ -385,7 +385,7 @@ static const struct of_device_id uniphier_reset_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, uniphier_reset_match);
>  
> -int uniphier_reset_probe(struct platform_device *pdev)
> +static int uniphier_reset_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	const struct of_device_id *match;

Thanks, I've squashed this into the original commit.

regards
Philipp
