From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed, 18 Apr 2018 09:44:28 +0200
Subject: [PATCH v2 6/6] drm/atmel-hlcdc: fix broken release date
In-Reply-To: <20180417131052.16336-7-peda@axentia.se>
References: <20180417131052.16336-1-peda@axentia.se>
 <20180417131052.16336-7-peda@axentia.se>
Message-ID: <20180418094428.6db785dc@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Apr 2018 15:10:52 +0200
Peter Rosin <peda@axentia.se> wrote:

> Bump the minor version while at it.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index 8523c40fac94..aa48f287b5ca 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -763,9 +763,9 @@ static struct drm_driver atmel_hlcdc_dc_driver = {
>  	.fops = &fops,
>  	.name = "atmel-hlcdc",
>  	.desc = "Atmel HLCD Controller DRM",
> -	.date = "20141504",

I guess I used YYYYDDMM format :-).

> +	.date = "20180409",
>  	.major = 1,
> -	.minor = 0,
> +	.minor = 1,

Don't know what the strategy is regarding date and minor version
updates. I never had to update that before, so I guess it's not
important to userspace anyway.

>  };
>  
>  static int atmel_hlcdc_dc_drm_init(struct platform_device *pdev)
