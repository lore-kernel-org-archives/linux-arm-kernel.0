From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 13 Jul 2017 01:49:25 +0200
Subject: [PATCH v2 3/6] ARM: dts: rockchip: enable io-domain for rk3229-evb
In-Reply-To: <201707061400.5K7lBcIR%fengguang.wu@intel.com>
References: <201707061400.5K7lBcIR%fengguang.wu@intel.com>
Message-ID: <7044113.TZbuKUQOGQ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 6. Juli 2017, 14:47:50 CEST schrieb kbuild test robot:
> Hi David,
> 
> [auto build test ERROR on rockchip/for-next]
> [cannot apply to v4.12]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Frank-Wang/ARM-dts-rockchip-add-regulator-nodes-for-rk3229-evb/20170706-094621
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
> config: arm-at91_dt_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
> >> Error: arch/arm/boot/dts/rk3229-evb.dts:164.1-12 Label or path io_domains not found
>    FATAL ERROR: Syntax error parsing input tree

This most likely ok, as this patch builds on top of

ARM: dts: rockchip: Add io-domain node for rk3228
https://patchwork.kernel.org/patch/9803973/

which creates the core node referenced here.
