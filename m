From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 14 Sep 2016 08:19:02 -0700
Subject: [PATCH 1/2] i2c: meson: add gxbb compatible string
In-Reply-To: <1473846557-18123-2-git-send-email-jbrunet@baylibre.com> (Jerome
 Brunet's message of "Wed, 14 Sep 2016 11:49:16 +0200")
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
 <1473846557-18123-2-git-send-email-jbrunet@baylibre.com>
Message-ID: <7hr38mmrvd.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> From: Neil Armstrong <narmstrong@baylibre.com>
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/i2c/busses/i2c-meson.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
> index 76e28980904f..30977e31cd98 100644
> --- a/drivers/i2c/busses/i2c-meson.c
> +++ b/drivers/i2c/busses/i2c-meson.c
> @@ -473,6 +473,7 @@ static int meson_i2c_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id meson_i2c_match[] = {
>  	{ .compatible = "amlogic,meson6-i2c" },
> +	{ .compatible = "amlogic,meson-gxbb-i2c" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, meson_i2c_match);
