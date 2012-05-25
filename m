From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 25 May 2012 17:57:15 -0600
Subject: [PATCH v4 1/6] gpio: fix a typo of comment message
In-Reply-To: <1337952980-14621-1-git-send-email-b29396@freescale.com>
References: <1337952980-14621-1-git-send-email-b29396@freescale.com>
Message-ID: <20120525235715.CE8223E0C7F@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 May 2012 21:36:15 +0800, Dong Aisheng <b29396@freescale.com> wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

Applied, thanks.

g.

> ---
>  drivers/gpio/gpiolib-of.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index d18068a..8389d4a 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -21,7 +21,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/slab.h>
>  
> -/* Private data structure for of_gpiochip_is_match */
> +/* Private data structure for of_gpiochip_find_and_xlate */
>  struct gg_data {
>  	enum of_gpio_flags *flags;
>  	struct of_phandle_args gpiospec;
> -- 
> 1.7.0.4
> 
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
