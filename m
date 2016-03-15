From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 15 Mar 2016 13:25:57 +0900
Subject: [PATCH v2 7/7] ARM: dts: Add initial gpio setting of MMC2 device
 for exynos3250-monk
In-Reply-To: <201603151221.FDX9rQCr%fengguang.wu@intel.com>
References: <201603151221.FDX9rQCr%fengguang.wu@intel.com>
Message-ID: <56E78ED5.9060604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2016? 03? 15? 13:18, kbuild test robot wrote:
> Hi Chanwoo,
> 
> [auto build test ERROR on v4.5-rc7]
> [also build test ERROR on next-20160314]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Chanwoo-Choi/ARM-dts-Add-new-Exynos3250-based-ARTIK5-module-dtsi-file/20160315-101326
> config: arm-exynos_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>>> Error: arch/arm/boot/dts/exynos3250-monk.dts:564.9-10 syntax error
>    FATAL ERROR: Unable to parse input tree

>    FATAL ERROR: Unable to parse input tree

This patch depend on patch[1]. I send the separate patch-set.
To build this patch, patch[1] should be applied. It is my mistake.
[1] https://lkml.org/lkml/2016/3/14/245

Best Regards,
Chanwoo Choi
