From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 30 May 2016 07:44:17 -0700
Subject: [PATCH 1/3] watchdog: Add Meson GXBB Watchdog Driver
In-Reply-To: <1464614948-28247-2-git-send-email-narmstrong@baylibre.com>
References: <1464614948-28247-1-git-send-email-narmstrong@baylibre.com>
 <1464614948-28247-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <574C51C1.1060609@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2016 06:29 AM, Neil Armstrong wrote:
> Add watchdog specific driver for Amlogic Meson GXBB SoC.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/watchdog/Makefile         |   1 +
>   drivers/watchdog/meson_gxbb_wdt.c | 277 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 278 insertions(+)
>   create mode 100644 drivers/watchdog/meson_gxbb_wdt.c
>
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9bde095..7679d93 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_QCOM_WDT) += qcom-wdt.o
>   obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
>   obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
>   obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
> +obj-$(CONFIG_MESON_WATCHDOG) += meson_gxbb_wdt.o

No extra Kconfig entry ? Why ?
