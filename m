From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 01 Aug 2017 20:52:34 +0200
Subject: [rockchip:v4.14-armsoc/dts32 24/24] Error:
 arch/arm/boot/dts/rv1108.dtsi:166.18-19 syntax error
In-Reply-To: <201708020247.iHTNS8tt%fengguang.wu@intel.com>
References: <201708020247.iHTNS8tt%fengguang.wu@intel.com>
Message-ID: <5139664.u4Jz45l4se@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 2. August 2017, 02:46:48 CEST schrieb kbuild test robot:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git v4.14-armsoc/dts32
> head:   752db55c894e48ff08a89946604950071bed5f1e
> commit: 752db55c894e48ff08a89946604950071bed5f1e [24/24] ARM: dts: rockchip: add watchdog dt node for rv1108
> config: arm-at91_dt_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 752db55c894e48ff08a89946604950071bed5f1e
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
> >> Error: arch/arm/boot/dts/rv1108.dtsi:166.18-19 syntax error
>    FATAL ERROR: Unable to parse input tree

Thanks for noticing. I blame it on the heat today, that I applied the
rv1108-watchdog patch without noticing the missing clock-id.

I'll drop it again, until the clock-id is present.


Heiko
