From: lkp@intel.com (kbuild test robot)
Date: Sun, 10 Sep 2017 03:57:43 +0800
Subject: [PATCH v2 2/3] ARM: dts: exynos: Add clean name of compatible.
In-Reply-To: <1504777143-29834-3-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <201709100314.wmGSSdNC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoegeun,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.13 next-20170908]
[cannot apply to drm-exynos/exynos-drm/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hoegeun-Kwon/drm-exynos-gsc-Support-the-hardware-rotation-limits/20170910-015155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/exynos5250.dtsi:640.40-41 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23094 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170910/477cbfb6/attachment-0001.gz>
