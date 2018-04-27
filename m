From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 27 Apr 2018 17:28:27 +0200
Subject: [PATCH] arm64: defconfig: enable CONFIG_SPI_ARMADA_3700
In-Reply-To: <20180406140048.4602-1-gregory.clement@bootlin.com> (Gregory
 CLEMENT's message of "Fri, 6 Apr 2018 16:00:48 +0200")
References: <20180406140048.4602-1-gregory.clement@bootlin.com>
Message-ID: <87a7tod5yc.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On ven., avril 06 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> The SPI is used on many boards (especially for the serial
> flashes). Enable it by default.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Applied on mvebu/arm64

Gregory

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 634b373785c4..c8aabed6672f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -285,6 +285,7 @@ CONFIG_I2C_UNIPHIER_F=y
>  CONFIG_I2C_RCAR=y
>  CONFIG_I2C_CROS_EC_TUNNEL=y
>  CONFIG_SPI=y
> +CONFIG_SPI_ARMADA_3700=y
>  CONFIG_SPI_MESON_SPICC=m
>  CONFIG_SPI_MESON_SPIFC=m
>  CONFIG_SPI_BCM2835=m
> -- 
> 2.16.3
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
