From: Wenyou.Yang@microchip.com (Wenyou.Yang at microchip.com)
Date: Wed, 2 Nov 2016 05:46:14 +0000
Subject: [PATCH v2] ARM: at91/dt: add dts file for sama5d36ek CMP board
In-Reply-To: <201611021345.WcgqcfPD%fengguang.wu@intel.com>
References: <1478055958-8463-1-git-send-email-wenyou.yang@atmel.com>
 <201611021345.WcgqcfPD%fengguang.wu@intel.com>
Message-ID: <F9F4555C4E01D7469D37975B62D0EFBB41DD2B@CHN-SV-EXMX07.mchp-main.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org





> -----Original Message-----
> From: kbuild test robot [mailto:lkp at intel.com]
> Sent: 2016?11?2? 13:28
> To: Wenyou Yang - A41535 <Wenyou.Yang@microchip.com>
> Cc: kbuild-all at 01.org; Nicolas Ferre <nicolas.ferre@atmel.com>; Alexandre
> Belloni <alexandre.belloni@free-electrons.com>; Russell King
> <linux@arm.linux.org.uk>; Rob Herring <robh+dt@kernel.org>; Pawel Moll
> <pawel.moll@arm.com>; Mark Rutland <mark.rutland@arm.com>; Ian Campbell
> <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>; linux-
> kernel at vger.kernel.org; Wenyou Yang - A41535
> <Wenyou.Yang@microchip.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Wenyou Yang - A41535
> <Wenyou.Yang@microchip.com>
> Subject: Re: [PATCH v2] ARM: at91/dt: add dts file for sama5d36ek CMP board
> 
> Hi Wenyou,
> 
> [auto build test ERROR on at91/at91-next] [also build test ERROR on v4.9-rc3
> next-20161028] [if your patch is applied to the wrong git tree, please drop us a
> note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Wenyou-Yang/ARM-at91-dt-add-
> dts-file-for-sama5d36ek-CMP-board/20161102-111152
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git at91-
> next
> config: arm-at91_dt_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-
> tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm
> 
> All errors (new ones prefixed by >>):
> 
> >> Error: arch/arm/boot/dts/sama5d3xmb_cmp.dtsi:143.17-18 syntax error
>    FATAL ERROR: Unable to parse input tree

Oh, this patch is based on the patch I sent before.
[PATCH] pinctrl: at91: add support for OUTPUT config
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/464354.html

I forgot adding this information.

Sorry. 


Best Regards,
Wenyou Yang
