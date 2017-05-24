From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 24 May 2017 10:38:48 +0200
Subject: [PATCH 2/2] pinctrl: meson-gxbb: Add missing GPIODV_18 pin entry
In-Reply-To: <1495548559-22261-3-git-send-email-narmstrong@baylibre.com>
References: <1495548559-22261-1-git-send-email-narmstrong@baylibre.com>
 <1495548559-22261-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495615128.14589.1.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-05-23 at 16:09 +0200, Neil Armstrong wrote:
> GPIODV_18 entry was missing in the original driver push.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> 
> Fixes: 468c234f9ed7 ("pinctrl: amlogic: Add support for Amlogic Meson GXBB
> SoC")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> ?drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 1 +
> ?1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> index 3ccb0f4f..7d897c5 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> @@ -85,6 +85,7 @@
> ?	MESON_PIN(GPIODV_15, EE_OFF),
> ?	MESON_PIN(GPIODV_16, EE_OFF),
> ?	MESON_PIN(GPIODV_17, EE_OFF),
> +	MESON_PIN(GPIODV_18, EE_OFF),
> ?	MESON_PIN(GPIODV_19, EE_OFF),
> ?	MESON_PIN(GPIODV_20, EE_OFF),
> ?	MESON_PIN(GPIODV_21, EE_OFF),
