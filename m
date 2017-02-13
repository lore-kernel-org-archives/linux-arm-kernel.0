From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 13 Feb 2017 10:36:10 -0800
Subject: [PATCH 07/10] ARM: davinci: fix a whitespace error
In-Reply-To: <1486485683-11427-8-git-send-email-bgolaszewski@baylibre.com>
 (Bartosz Golaszewski's message of "Tue, 7 Feb 2017 17:41:20 +0100")
References: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
 <1486485683-11427-8-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <m2o9y6djl1.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

> There's a stray tab in da850_vpif_legacy_init(). Remove it.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Folding into the original,

Kevin

> ---
>  arch/arm/mach-davinci/pdata-quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
> index a186513..94948c1 100644
> --- a/arch/arm/mach-davinci/pdata-quirks.c
> +++ b/arch/arm/mach-davinci/pdata-quirks.c
> @@ -111,7 +111,7 @@ static struct vpif_capture_config da850_vpif_capture_config = {
>  static void __init da850_vpif_legacy_init(void)
>  {
>  	int ret;
> -	
> +
>  	/* LCDK doesn't have the 2nd TVP514x on CH1 */
>  	if (of_machine_is_compatible("ti,da850-lcdk"))
>  		da850_vpif_capture_config.subdev_count = 1;
