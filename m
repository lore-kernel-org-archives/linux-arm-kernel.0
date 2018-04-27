From: s-anna@ti.com (Suman Anna)
Date: Fri, 27 Apr 2018 12:11:54 -0500
Subject: [PATCH v6 5/7] remoteproc/davinci: use octal permissions for
 module_param()
In-Reply-To: <20180417173038.25510-6-brgl@bgdev.pl>
References: <20180417173038.25510-1-brgl@bgdev.pl>
 <20180417173038.25510-6-brgl@bgdev.pl>
Message-ID: <0bd29608-fe2c-50c8-3f8c-eb1b2f001a6d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2018 12:30 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Checkpatch recommends to use octal perms instead of S_IRUGO.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Looks like you missed by Acked-by from v3, so adding it back

Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index f134192922e0..b668e32996e2 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -25,7 +25,7 @@
>  #include "remoteproc_internal.h"
>  
>  static char *da8xx_fw_name;
> -module_param(da8xx_fw_name, charp, S_IRUGO);
> +module_param(da8xx_fw_name, charp, 0444);
>  MODULE_PARM_DESC(da8xx_fw_name,
>  		 "Name of DSP firmware file in /lib/firmware (if not specified defaults to 'rproc-dsp-fw')");
>  
> 
