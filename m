From: nm@ti.com (Nishanth Menon)
Date: Fri, 5 Oct 2018 10:04:40 -0500
Subject: [PATCH] arm64: defconfig: Enable SERIAL_8250_OMAP
In-Reply-To: <20181005100140.16716-1-lokeshvutla@ti.com>
References: <20181005100140.16716-1-lokeshvutla@ti.com>
Message-ID: <20181005150440.6efkltod3nri6roy@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:01-20181005, Lokesh Vutla wrote:
> Enabling CONFIG_SERIAL_8250_OMAP that is used by TI's
> AM6 SoC.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> - Based on next tag: next-20181005
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 030186c180aa..0baf31ca069f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -288,6 +288,7 @@ CONFIG_SERIAL_8250_EXTENDED=y
>  CONFIG_SERIAL_8250_SHARE_IRQ=y
>  CONFIG_SERIAL_8250_BCM2835AUX=y
>  CONFIG_SERIAL_8250_DW=y
> +CONFIG_SERIAL_8250_OMAP=y
>  CONFIG_SERIAL_8250_MT6577=y
>  CONFIG_SERIAL_8250_UNIPHIER=y
>  CONFIG_SERIAL_OF_PLATFORM=y

Olof, any chance to get this for v4.20?

Acked-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
