From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 Jul 2012 18:10:04 +0900
Subject: [PATCH] ARM: S3C64XX: Don't specify an irq_base for WM1192-EV1
 board
In-Reply-To: <1341920671-8348-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1341920671-8348-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <0fa901cd600e$1fbf93f0$5f3ebbd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> None of the GPIO IRQs are connected so there is no reason to specify a
> base.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-smdk6410.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-
> s3c64xx/mach-smdk6410.c
> index df3103d..0fe4f15 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -566,7 +566,6 @@ static struct wm831x_status_pdata wm1192_led8_pdata =
> {
> 
>  static struct wm831x_pdata smdk6410_wm1192_pdata = {
>  	.pre_init = wm1192_pre_init,
> -	.irq_base = IRQ_BOARD_START,
> 
>  	.backlight = &wm1192_backlight_pdata,
>  	.dcdc = {
> --
> 1.7.10

Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
