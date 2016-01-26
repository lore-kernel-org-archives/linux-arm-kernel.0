From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 26 Jan 2016 09:54:38 +0100
Subject: ARM: mvebu_v5_defconfig: Enable sound module needed for OpenRD
In-Reply-To: <20160125214547.GB12980@jirafa.cyrius.com> (Martin Michlmayr's
 message of "Mon, 25 Jan 2016 13:45:47 -0800")
References: <20160111042540.GA31022@jirafa.cyrius.com>
 <87zivteq7t.fsf@free-electrons.com>
 <20160125214547.GB12980@jirafa.cyrius.com>
Message-ID: <87io2gd8kx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,
 
 On lun., janv. 25 2016, Martin Michlmayr <tbm@cyrius.com> wrote:

> * Gregory CLEMENT <gregory.clement@free-electrons.com> [2016-01-25 14:36]:
>>  On lun., janv. 11 2016, Martin Michlmayr <tbm@cyrius.com> wrote:
>> > OpenRD-Client requires the CS42L51 codec.
>> 
>> This patch do not apply anymore on v4.5-rc1.
>> 
>> Could you regenerate it, please?
>> 
>> Then I will apply it on mvebu/defconfig with Andrew'w Reviewed-by tag.
>
> ARM: mvebu_v5_defconfig: Enable sound module needed for OpenRD
>
> OpenRD-Client requires the CS42L51 codec.
>
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

This is not what I expected, it is not a proper patch so I can't apply
it. However I did it myself.


So, I applied on mvebu/defconfig

Thanks,

Gregory


>
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index af29780..9317e5a 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -137,6 +137,7 @@ CONFIG_SND=y
>  CONFIG_SND_SOC=y
>  CONFIG_SND_KIRKWOOD_SOC=y
>  CONFIG_SND_SOC_ALC5623=y
> +CONFIG_SND_SOC_CS42L51_I2C=y
>  CONFIG_SND_SIMPLE_CARD=y
>  CONFIG_HID_DRAGONRISE=y
>  CONFIG_HID_GYRATION=y
>
> -- 
> Martin Michlmayr
> http://www.cyrius.com/

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
