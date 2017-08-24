From: xiaolong.ye@intel.com (Ye Xiaolong)
Date: Thu, 24 Aug 2017 14:05:19 +0800
Subject: [PATCH] ARM: sun8i: a83t: Add device tree for Sinovoip Bananapi
 BPI-M3
In-Reply-To: <f14d6c43ddcf403775dfb6efe25e7196@aosc.io>
References: <201708200827.WQojuopU%fengguang.wu@intel.com>
 <f14d6c43ddcf403775dfb6efe25e7196@aosc.io>
Message-ID: <20170824060519.GC7797@yexl-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20, icenowy at aosc.io wrote:
>? 2017-08-20 08:59?kbuild test robot ???
>>Hi Chen-Yu,
>>
>>[auto build test ERROR on robh/for-next]
>>[also build test ERROR on v4.13-rc5 next-20170817]
>>[if your patch is applied to the wrong git tree, please drop us a note
>>to help improve the system]
>
>In fact this tree shouldn't be applied on robh's tree, but the
>arm-soc tree
>or its downstream, sunxi tree.

Thanks for the feedback, we'll improve the system accordingly.

Thanks,
Xiaolong
>
>>
>>url:
>>https://github.com/0day-ci/linux/commits/Chen-Yu-Tsai/ARM-sun8i-a83t-Add-device-tree-for-Sinovoip-Bananapi-BPI-M3/20170820-055904
>>base:
>>https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
>>for-next
>>config: arm-at91_dt_defconfig (attached as .config)
>>compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
>>reproduce:
>>        wget
>>https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross
>>-O ~/bin/make.cross
>>        chmod +x ~/bin/make.cross
>>        # save the attached .config to linux build tree
>>        make.cross ARCH=arm
>>
>>All errors (new ones prefixed by >>):
>>
>>>>Error: arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts:64.1-7
>>>>Label or path ehci0 not found
>>>>Error: arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts:71.1-6
>>>>Label or path mmc0 not found
>>>>Error: arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts:81.1-6
>>>>Label or path mmc2 not found
>>>>Error: arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts:91.1-7
>>>>Label or path r_rsb not found
>>>>Error: arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts:145.1-8
>>>>Label or path usbphy not found
>>   FATAL ERROR: Syntax error parsing input tree
>>
>>---
>>0-DAY kernel test infrastructure                Open Source
>>Technology Center
>>https://lists.01.org/pipermail/kbuild-all                   Intel
>>Corporation
>>
>>_______________________________________________
>>linux-arm-kernel mailing list
>>linux-arm-kernel at lists.infradead.org
>>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
