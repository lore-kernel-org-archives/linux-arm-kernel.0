From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 28 May 2014 11:56:36 +0200
Subject: [PATCH] pwm: i.MX: Cleanup indentation for register definitions
In-Reply-To: <1401185980-29536-1-git-send-email-Ying.Liu@freescale.com>
References: <1401185980-29536-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20140528115636.4ad791aa@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Liu Ying wrote:
> This patch contains no logic change to cleanup indentation
> for register definitions only.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> Cc: linux-pwm at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
>  drivers/pwm/pwm-imx.c |   26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index cc47733..0784554 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -21,24 +21,24 @@
>  
>  /* i.MX1 and i.MX21 share the same PWM function block: */
>  
> -#define MX1_PWMC    0x00   /* PWM Control Register */
> -#define MX1_PWMS    0x04   /* PWM Sample Register */
> -#define MX1_PWMP    0x08   /* PWM Period Register */
> +#define MX1_PWMC			0x00   /* PWM Control Register */
> +#define MX1_PWMS			0x04   /* PWM Sample Register */
> +#define MX1_PWMP			0x08   /* PWM Period Register */
>  
> -#define MX1_PWMC_EN		(1 << 4)
> +#define MX1_PWMC_EN			(1 << 4)
>  
>  /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
>  
> -#define MX3_PWMCR                 0x00    /* PWM Control Register */
> -#define MX3_PWMSAR                0x0C    /* PWM Sample Register */
> -#define MX3_PWMPR                 0x10    /* PWM Period Register */
> -#define MX3_PWMCR_PRESCALER(x)    (((x - 1) & 0xFFF) << 4)
> -#define MX3_PWMCR_DOZEEN                (1 << 24)
> -#define MX3_PWMCR_WAITEN                (1 << 23)
> +#define MX3_PWMCR			0x00    /* PWM Control Register */
> +#define MX3_PWMSAR			0x0C    /* PWM Sample Register */
> +#define MX3_PWMPR			0x10    /* PWM Period Register */
> +#define MX3_PWMCR_PRESCALER(x)		(((x - 1) & 0xFFF) << 4)
                                                   ^
You could also add the missing () around the macro argument when you
are changing this line anyway.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
