From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 13 Dec 2017 22:07:36 +0800
Subject: [PATCH 2/3] reset: meson-axg: add compatible string for Meson-AXG
 SoC
In-Reply-To: <20171110084650.31325-2-yixun.lan@amlogic.com>
References: <20171110084650.31325-1-yixun.lan@amlogic.com>
 <20171110084650.31325-2-yixun.lan@amlogic.com>
Message-ID: <3b61170c-c352-6b23-ab19-82c76954a911@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp

On 11/10/2017 04:46 PM, Yixun Lan wrote:
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

it's generally a ping to the status of these two patches[1], are they
ready to go? or do you have any comment? or do you want me to send
another version with Neil's Reviewed-by added[1]

thanks

Yixun

[1]
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005278.html

[2]
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005318.html
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005319.html
