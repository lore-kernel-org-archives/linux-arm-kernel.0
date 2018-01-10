From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 10 Jan 2018 11:43:46 -0500 (EST)
Subject: [PATCH] ARM: bL_switcher: add MODULE_LICENSE tag
In-Reply-To: <20180110162911.461577-1-arnd@arndb.de>
References: <20180110162911.461577-1-arnd@arndb.de>
Message-ID: <nycvar.YSQ.7.76.1801101143240.13881@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Jan 2018, Arnd Bergmann wrote:

> Without this tag, we get a build warning:
> 
> WARNING: modpost: missing MODULE_LICENSE() in arch/arm/common/bL_switcher_dummy_if.o
> 
> For completeness, I'm also adding author and description fields.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/common/bL_switcher_dummy_if.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/common/bL_switcher_dummy_if.c b/arch/arm/common/bL_switcher_dummy_if.c
> index 4c10c6452678..f4dc1714a79e 100644
> --- a/arch/arm/common/bL_switcher_dummy_if.c
> +++ b/arch/arm/common/bL_switcher_dummy_if.c
> @@ -57,3 +57,7 @@ static struct miscdevice bL_switcher_device = {
>  	&bL_switcher_fops
>  };
>  module_misc_device(bL_switcher_device);
> +
> +MODULE_AUTHOR("Nicolas Pitre <nico@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("big.LITTLE switcher dummy user interface");
> -- 
> 2.9.0
> 
> 
