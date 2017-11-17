From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 17 Nov 2017 14:08:38 +0100
Subject: [PATCH 2/3] reset: meson-axg: add compatible string for Meson-AXG
 SoC
In-Reply-To: <20171110084650.31325-2-yixun.lan@amlogic.com>
References: <20171110084650.31325-1-yixun.lan@amlogic.com>
 <20171110084650.31325-2-yixun.lan@amlogic.com>
Message-ID: <6948ecf6-5450-7bc9-0dd4-e761685c46e7@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2017 09:46, Yixun Lan wrote:
> Try to add compatible string explictly to support new Meson-AXG SoC.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/reset/reset-meson.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index c419a3753d00..93cbee1ae8ef 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -139,6 +139,8 @@ static const struct of_device_id meson_reset_dt_ids[] = {
>  	   .data = &meson_reset_meson8_ops, },
>  	 { .compatible = "amlogic,meson-gxbb-reset",
>  	   .data = &meson_reset_gx_ops, },
> +	 { .compatible = "amlogic,meson-axg-reset",
> +	   .data = &meson_reset_gx_ops, },
>  	 { /* sentinel */ },
>  };
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
