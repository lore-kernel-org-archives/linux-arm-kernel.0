From: baruch@tkos.co.il (Baruch Siach)
Date: Sat, 22 Sep 2018 20:48:26 +0300
Subject: [PATCH 1/2] MAINTAINERS: add new entries for Armada 8K cpufreq
 driver
In-Reply-To: <20180921154326.10776-1-gregory.clement@bootlin.com>
References: <20180921154326.10776-1-gregory.clement@bootlin.com>
Message-ID: <87efdlifth.fsf@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Gregory CLEMENT writes:
> This new driver belongs to the mvebu family, update the MAINTAINER file
> to document it.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5b256b25905..7e969fbb3626 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1657,6 +1657,7 @@ F:	arch/arm/configs/mvebu_*_defconfig
>  F:	arch/arm/mach-mvebu/
>  F:	arch/arm64/boot/dts/marvell/armada*
>  F:	drivers/cpufreq/armada-37xx-cpufreq.c
> +F!	drivers/cpufreq/armada-8k-cpufreq.c

s/!/:/

baruch

>  F:	drivers/cpufreq/mvebu-cpufreq.c
>  F:	drivers/irqchip/irq-armada-370-xp.c
>  F:	drivers/irqchip/irq-mvebu-*

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
