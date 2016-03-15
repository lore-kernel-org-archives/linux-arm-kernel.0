From: lkp@intel.com (kbuild test robot)
Date: Tue, 15 Mar 2016 12:18:15 +0800
Subject: [PATCH v2 7/7] ARM: dts: Add initial gpio setting of MMC2 device
 for exynos3250-monk
In-Reply-To: <1458007695-3627-8-git-send-email-cw00.choi@samsung.com>
Message-ID: <201603151221.FDX9rQCr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

[auto build test ERROR on v4.5-rc7]
[also build test ERROR on next-20160314]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Chanwoo-Choi/ARM-dts-Add-new-Exynos3250-based-ARTIK5-module-dtsi-file/20160315-101326
config: arm-exynos_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/exynos3250-monk.dts:564.9-10 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23852 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160315/e5eb0cdc/attachment-0001.obj>
