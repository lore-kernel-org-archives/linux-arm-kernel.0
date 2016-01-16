From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 16 Jan 2016 18:27:00 +0100
Subject: ARM: mvebu_v5_defconfig: Enable sound module needed for OpenRD
In-Reply-To: <20160111042540.GA31022@jirafa.cyrius.com>
References: <20160111042540.GA31022@jirafa.cyrius.com>
Message-ID: <20160116172700.GD9880@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 10, 2016 at 08:25:40PM -0800, Martin Michlmayr wrote:
> OpenRD-Client requires the CS42L51 codec.
> 
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

Reviewd-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew

> ---
>  arch/arm/configs/mvebu_v5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index 79e6260..25c788a 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -109,6 +109,7 @@ CONFIG_SND=y
>  CONFIG_SND_SOC=y
>  CONFIG_SND_KIRKWOOD_SOC=y
>  CONFIG_SND_SOC_ALC5623=y
> +CONFIG_SND_SOC_CS42L51_I2C=y
>  CONFIG_SND_SIMPLE_CARD=y
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
> -- 
> 2.1.4
> 
> -- 
> Martin Michlmayr
> http://www.cyrius.com/
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
