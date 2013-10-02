From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 02 Oct 2013 10:32:42 +0200
Subject: [Add SMP support for Allwinner A20: PATCH V4 0/3]
In-Reply-To: <1380642145-17295-1-git-send-email-cinifr@gmail.com>
References: <1380642145-17295-1-git-send-email-cinifr@gmail.com>
Message-ID: <524BDA2A.7090108@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2013 05:42 PM, Fan Rong wrote:


> This is the version 4 patch. It use smp_prepare_cpus replacing early_init as cpuconfigure map init funcation caller and use sun7i replacing sunxi7i as funcation name and variable name.

Hi Fan,

your patchset does not have a changelog neither a description. You 
should fix this first if you want a proper review.

Thanks
   -- Daniel

>
> Fan Rong (3):
>    Add smp support for Allwinner A20(sunxi 7i).
>    Add cpuconfig nodes in dts for smp configure.
>    Add arch count timer node in dts for Allwinner A20(sunxi 7i).
>
>   arch/arm/boot/dts/sun7i-a20.dtsi |  15 ++++++
>   arch/arm/mach-sunxi/Makefile     |   2 +
>   arch/arm/mach-sunxi/headsmp.S    |  18 +++++++
>   arch/arm/mach-sunxi/platsmp.c    | 114 +++++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-sunxi/sunxi.c      |   3 ++
>   5 files changed, 152 insertions(+)
>   create mode 100644 arch/arm/mach-sunxi/headsmp.S
>   create mode 100644 arch/arm/mach-sunxi/platsmp.c
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
