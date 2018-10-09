From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 9 Oct 2018 09:56:52 +0200
Subject: [PATCH] PM / AVS: SmartReflex: Fix module licence specification
In-Reply-To: <20181008091818.1145-1-uwe@kleine-koenig.org>
References: <20181008091818.1145-1-uwe@kleine-koenig.org>
Message-ID: <CAJZ5v0jEHcPKchOmzd9AewGCT0zkXnRgL=QGZTW-xWcJ12HNoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2018 at 11:23 AM Uwe Kleine-K?nig <uwe@kleine-koenig.org> wrote:
>
> The header of this file claims "version 2" and not "or later". So adapt
> the module licence specification accordingly.
>
> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> ---
>  drivers/power/avs/smartreflex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
> index d29b6313cafc..9ed30b5d32c2 100644
> --- a/drivers/power/avs/smartreflex.c
> +++ b/drivers/power/avs/smartreflex.c
> @@ -1062,6 +1062,6 @@ static void __exit sr_exit(void)
>  module_exit(sr_exit);
>
>  MODULE_DESCRIPTION("OMAP Smartreflex Driver");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:" DRIVER_NAME);
>  MODULE_AUTHOR("Texas Instruments Inc");
> --

While you are at it, why don't you add a proper SPDX license ID to
this file and drop the license bolierplate from the heading comment?
