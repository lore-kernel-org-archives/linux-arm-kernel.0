From: alex.g@adaptrum.com (Alexandru Gagniuc)
Date: Fri, 11 Aug 2017 10:47:04 -0700
Subject: [PATCH v2 1/5] reset: add reset-simple to unify socfpga, stm32,
 sunxi, and zx2967
In-Reply-To: <20170811130618.3676-2-p.zabel@pengutronix.de>
References: <20170811130618.3676-1-p.zabel@pengutronix.de>
 <20170811130618.3676-2-p.zabel@pengutronix.de>
Message-ID: <0d8e5468-866a-eac8-d9ec-b23f47df8bf3@adaptrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 08/11/2017 06:06 AM, Philipp Zabel wrote:
[snip]

> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 52d5251660b9b..f7ba01a71daee 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -68,6 +68,16 @@ config RESET_PISTACHIO
>  	help
>  	  This enables the reset driver for ImgTec Pistachio SoCs.
>
> +config RESET_SIMPLE
> +	bool "Simple Reset Controller Driver" if COMPILE_TEST

Another question. Is there a reason this is depended on COMPILE_TEST ?

Alex
