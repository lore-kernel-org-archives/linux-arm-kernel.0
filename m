From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 20 Oct 2016 12:01:20 +0200
Subject: [RESEND PATCH v2 1/3] reset: oxnas: Add OX820 support
In-Reply-To: <20161005152710.2898-2-narmstrong@baylibre.com>
References: <20161005152710.2898-1-narmstrong@baylibre.com>
 <20161005152710.2898-2-narmstrong@baylibre.com>
Message-ID: <1476957680.2709.21.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 05.10.2016, 17:27 +0200 schrieb Neil Armstrong:
> In order to support the Oxford Semiconductor OX820 SoC, add a new
> compatible string.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/reset/reset-oxnas.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/reset-oxnas.c b/drivers/reset/reset-oxnas.c
> index 9449805..0d9036d 100644
> --- a/drivers/reset/reset-oxnas.c
> +++ b/drivers/reset/reset-oxnas.c
> @@ -80,6 +80,7 @@ static const struct reset_control_ops oxnas_reset_ops = {
>  
>  static const struct of_device_id oxnas_reset_dt_ids[] = {
>  	 { .compatible = "oxsemi,ox810se-reset", },
> +	 { .compatible = "oxsemi,ox820-reset", },
>  	 { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, oxnas_reset_dt_ids);

Applied all three, thanks.

regards
Philipp
