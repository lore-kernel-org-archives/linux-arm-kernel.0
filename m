From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 25 Jan 2016 14:36:06 +0100
Subject: ARM: mvebu_v5_defconfig: Enable sound module needed for OpenRD
In-Reply-To: <20160111042540.GA31022@jirafa.cyrius.com> (Martin Michlmayr's
 message of "Sun, 10 Jan 2016 20:25:40 -0800")
References: <20160111042540.GA31022@jirafa.cyrius.com>
Message-ID: <87zivteq7t.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,
 
 On lun., janv. 11 2016, Martin Michlmayr <tbm@cyrius.com> wrote:

> OpenRD-Client requires the CS42L51 codec.

This patch do not apply anymore on v4.5-rc1.

Could you regenerate it, please?

Then I will apply it on mvebu/defconfig with Andrew'w Reviewed-by tag.

Thanks,

Gregory

>
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
> ---
>  arch/arm/configs/mvebu_v5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/mvebu_v5_defconfig
> b/arch/arm/configs/mvebu_v5_defconfig
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

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
