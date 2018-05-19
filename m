From: lkp@intel.com (kbuild test robot)
Date: Sat, 19 May 2018 18:07:32 +0800
Subject: [PATCH v3 4/4] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
In-Reply-To: <1526538126-51497-5-git-send-email-erin.lo@mediatek.com>
References: <1526538126-51497-5-git-send-email-erin.lo@mediatek.com>
Message-ID: <201805191807.I6rPLEQg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.17-rc5 next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Erin-Lo/Add-basic-support-for-Mediatek-MT8183-SoC/20180519-160349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-alldefconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/mediatek/mt8183.dtsi:137.9-10 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 8591 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180519/c9534ce8/attachment.gz>
