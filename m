From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 24 May 2017 10:38:09 +0200
Subject: [PATCH 1/2] pinctrl: meson-gxl: Add missing GPIODV_18 pin entry
In-Reply-To: <1495548559-22261-2-git-send-email-narmstrong@baylibre.com>
References: <1495548559-22261-1-git-send-email-narmstrong@baylibre.com>
 <1495548559-22261-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495615089.14589.0.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-05-23 at 16:09 +0200, Neil Armstrong wrote:
> GPIODV_18 entry was missing in the original driver push.
> 

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> Fixes: 0f15f500ff2c ("pinctrl: meson: Add GXL pinctrl definitions")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> ?drivers/pinctrl/meson/pinctrl-meson-gxl.c | 1 +
> ?1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> index 719ff1b..2bc1e3d 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> @@ -89,6 +89,7 @@
> ?	MESON_PIN(GPIODV_15, EE_OFF),
> ?	MESON_PIN(GPIODV_16, EE_OFF),
> ?	MESON_PIN(GPIODV_17, EE_OFF),
> +	MESON_PIN(GPIODV_18, EE_OFF),
> ?	MESON_PIN(GPIODV_19, EE_OFF),
> ?	MESON_PIN(GPIODV_20, EE_OFF),
> ?	MESON_PIN(GPIODV_21, EE_OFF),
