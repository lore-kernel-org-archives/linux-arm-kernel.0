From: jbrunet@baylibre.com (Jerome Brunet)
Date: Sun, 04 Jun 2017 22:02:12 +0200
Subject: [PATCH 2/3] arm: meson: select the clock controller for Meson8
In-Reply-To: <20170604183341.21417-3-martin.blumenstingl@googlemail.com>
References: <20170604183341.21417-1-martin.blumenstingl@googlemail.com>
 <20170604183341.21417-3-martin.blumenstingl@googlemail.com>
Message-ID: <1496606532.3552.18.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-06-04 at 20:33 +0200, Martin Blumenstingl wrote:
> Select COMMON_CLK_MESON8B also for MACH_MESON8 since the Meson8b clock
> controller driver can also be used on Meson8 SoCs now that we have a
> separate compatible for it.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
> ?arch/arm/mach-meson/Kconfig | 1 +
> ?1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index b6e3acc63e14..ee30511849ca 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -21,6 +21,7 @@ config MACH_MESON8
> ?	bool "Amlogic Meson8 SoCs support"
> ?	default ARCH_MESON
> ?	select MESON6_TIMER
> +	select COMMON_CLK_MESON8B
> ?
> ?config MACH_MESON8B
> ?	bool "Amlogic Meson8b SoCs support"
