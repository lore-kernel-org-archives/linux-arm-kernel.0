From: lkp@intel.com (kbuild test robot)
Date: Wed, 23 Mar 2016 16:00:46 +0800
Subject: [PATCH] ARM: dts: exynos: Enable SSS on Odroid X/X2/U3 family
In-Reply-To: <1458713417-32669-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <201603231551.uTnlB1aO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.5 next-20160323]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/ARM-dts-exynos-Enable-SSS-on-Odroid-X-X2-U3-family/20160323-141323
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm-exynos_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/exynos4412-odroid-common.dtsi:495.1-5 Label or path sss not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23859 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160323/ca643025/attachment-0001.obj>
