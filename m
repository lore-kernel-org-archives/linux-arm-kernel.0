From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 07 Jul 2018 17:28:54 +0200
Subject: [rockchip:v4.19-armsoc/dts64 7/11] Error:
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi:263.1-7 Label or path
 sound not found
In-Reply-To: <201807071814.GP4WAby3%fengguang.wu@intel.com>
References: <201807071814.GP4WAby3%fengguang.wu@intel.com>
Message-ID: <4714958.B0yVLYa4nN@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 7. Juli 2018, 12:36:16 CEST schrieb kbuild test robot:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git v4.19-armsoc/dts64
> head:   70c7ee25836e3d90f6b9b728db35ad3ff8f64c2d
> commit: eedeeb7b76ccd4a5a546c924c0dcf93d560670fd [7/11] arm64: dts: rockchip: move Chromebook-specific Gru-parts to a separate file
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout eedeeb7b76ccd4a5a546c924c0dcf93d560670fd
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm64 
> 
> Note: the rockchip/v4.19-armsoc/dts64 HEAD 70c7ee25836e3d90f6b9b728db35ad3ff8f64c2d builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
> >> Error: arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi:263.1-7 Label or path sound not found
> >> Error: arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi:355.1-6 Label or path wifi not found
>    FATAL ERROR: Syntax error parsing input tree

looks like I messed up patch ordering in that series. As it wasn't merged
anywere yet, I took the liberty of fixing up the branch to keep
bisectability intact.

Thanks for catching that issue
Heiko
