From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 27 Oct 2012 18:33:26 +0200
Subject: [PATCH] arm: mvebu: support for the Globalscale Mirabox MBX0001
 board
In-Reply-To: <1351354965-23875-1-git-send-email-gregory.clement@free-electrons.com>
References: <1351354965-23875-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121027183326.62ab505a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 27 Oct 2012 18:22:45 +0200, Gregory CLEMENT wrote:
> This platform, available from Globalscale has an Armada 370. For now,
> only the serial port is supported. Support for network, USB and other
> peripherals will be added as drivers for them become available for
> Armada 370 in mainline.

Great!

> +++ b/arch/arm/boot/dts/mbx001.dts

If you decided to name your platform with four zeros (00001), then the
file should be mbx0001.dts here.

> diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
> index 49d7915..e5269b4 100644
> --- a/arch/arm/mach-mvebu/armada-370-xp.c
> +++ b/arch/arm/mach-mvebu/armada-370-xp.c
> @@ -49,6 +49,7 @@ static void __init armada_370_xp_dt_init(void)
>  static const char * const armada_370_xp_dt_board_dt_compat[] = {
>  	"marvell,a370-db",
>  	"marvell,axp-db",
> +	"globalscale,mbx0001",
>  	NULL,
>  };

As Andrew said, sorted entries would be nicer.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
