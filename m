From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 13 Oct 2010 17:14:37 +0900
Subject: [PATCH 1/2] S3C64XX: Ensure samsung_keypad_cfg_gpio() is
	prototyped
In-Reply-To: <1286904195-1534-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1286904195-1534-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <002701cb6aae$af084680$0d18d380$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Since it's exported we should make sure we're using the prototype
> others see.
> 
Hi Mark,

Hmm...I'm not sure that we need really this. Of course, it can be helpful.
But if so, we have to apply this policy/rule to all of ours...but I think we
don't need it now.

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/setup-keypad.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/setup-keypad.c b/arch/arm/mach-
> s3c64xx/setup-keypad.c
> index d1fd722..f8ed0d2 100644
> --- a/arch/arm/mach-s3c64xx/setup-keypad.c
> +++ b/arch/arm/mach-s3c64xx/setup-keypad.c
> @@ -12,6 +12,7 @@
> 
>  #include <linux/gpio.h>
>  #include <plat/gpio-cfg.h>
> +#include <plat/keypad.h>
> 
>  void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
>  {
> --

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
