From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 29 May 2017 17:27:45 +0200
Subject: [PATCH v4 3/9] arm: dts: mt7623: add mt7623-mt6323.dtsi file
In-Reply-To: <201705281908.LU8TFOQ8%fengguang.wu@intel.com>
References: <201705281908.LU8TFOQ8%fengguang.wu@intel.com>
Message-ID: <d565b4dd-f6b7-ee43-ddfe-ae98328646ed@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/05/17 13:31, kbuild test robot wrote:
> Hi John,
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on v4.12-rc2 next-20170526]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/sean-wang-mediatek-com/arm-dts-extend-mt7623-support/20170525-142103
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next

Mediatek dts patches should be tested against:
https://github.com/mbgg/linux-mediatek.git for-next

Not sure why this happend, as this got already fixed in lkp-tests:
bc0c8847 ("mediatek: mark for-next branch")

Regards,
Matthias

> config: arm-allyesconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>          wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
> 
> All errors (new ones prefixed by >>):
> 
>>> Error: arch/arm/boot/dts/mt7623-mt6323.dtsi:33.1-7 Label or path pwrap not found
>>> Error: arch/arm/boot/dts/mt7623-mt6323.dtsi:261.1-6 Label or path mmc0 not found
>>> Error: arch/arm/boot/dts/mt7623-mt6323.dtsi:266.1-6 Label or path mmc1 not found
>     FATAL ERROR: Syntax error parsing input tree
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
