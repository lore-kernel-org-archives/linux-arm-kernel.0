From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 18 May 2017 09:18:23 +0200
Subject: [PATCH 3/3] arm: dts: rk322x: add watchdog device node.
In-Reply-To: <e39599a2-479a-11c3-a349-3c5a51fa130d@rock-chips.com>
References: <201705181148.b4AgD8sU%fengguang.wu@intel.com>
 <e39599a2-479a-11c3-a349-3c5a51fa130d@rock-chips.com>
Message-ID: <2701138.cVk9DUKsF1@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 18. Mai 2017, 11:58:04 CEST schrieb Frank Wang:
> Hi,
> 
> Sorry, I forgot to declare that this change required below patch on
> patchwork.
> https://patchwork.kernel.org/patch/9703945/

I found that yesterday already and brought everything in the correct order 
when applying :-)


Heiko

> 
> 
> BR.
> Frank
> 
> On 2017/5/18 11:18, kbuild test robot wrote:
> > Hi Frank,
> > 
> > [auto build test ERROR on rockchip/for-next]
> > [also build test ERROR on v4.12-rc1 next-20170517]
> > [if your patch is applied to the wrong git tree, please drop us a note to
> > help improve the system]
> > 
> > url:   
> > https://github.com/0day-ci/linux/commits/Frank-Wang/add-and-fix-some-devi
> > ce-node-for-rk322x-SoC/20170518-081958 base:  
> > https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
> > for-next config: arm-at91_dt_defconfig (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> > 
> > reproduce:
> >          wget
> >          https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/ma
> >          ke.cross -O ~/bin/make.cross chmod +x ~/bin/make.cross
> >          # save the attached .config to linux build tree
> >          make.cross ARCH=arm
> > 
> > All errors (new ones prefixed by >>):
> >>> Error: arch/arm/boot/dts/rk322x.dtsi:286.18-19 syntax error
> >>> 
> >     FATAL ERROR: Unable to parse input tree
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology
> > Center https://lists.01.org/pipermail/kbuild-all                   Intel
> > Corporation
