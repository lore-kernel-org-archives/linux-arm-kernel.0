From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 27 Apr 2016 10:06:52 +0200
Subject: [PATCH] ARM: at91/defconfig: add the HDMA controller to
 sama5_defconfig
In-Reply-To: <1461678431-17798-1-git-send-email-nicolas.ferre@atmel.com>
References: <1461678431-17798-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20160427080652.GC3264@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/2016 at 15:47:11 +0200, Nicolas Ferre wrote :
> Selection of the HDMAC option is now needed to allow some sama5 devices
> to have the DMA driver compiled.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  arch/arm/configs/sama5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index afbda413d61a..e002b3bba5b4 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -183,6 +183,7 @@ CONFIG_LEDS_TRIGGER_GPIO=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_AT91RM9200=y
>  CONFIG_DMADEVICES=y
> +CONFIG_AT_HDMAC=y
>  CONFIG_AT_XDMAC=y
>  # CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_IIO=y
> -- 
> 2.1.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
