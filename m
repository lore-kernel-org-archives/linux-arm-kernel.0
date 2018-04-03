From: lkp@intel.com (kbuild test robot)
Date: Wed, 4 Apr 2018 02:26:31 +0800
Subject: [PATCH] ARM64: dts: meson-axg: enable the eMMC controller
In-Reply-To: <20180403102651.60340-1-yixun.lan@amlogic.com>
References: <20180403102651.60340-1-yixun.lan@amlogic.com>
Message-ID: <201804040211.7wh3FnSx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20180403]
[cannot apply to robh/for-next v4.16 v4.16-rc7 v4.16-rc6 v4.16]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yixun-Lan/ARM64-dts-meson-axg-enable-the-eMMC-controller/20180403-224314
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/amlogic/meson-axg-s400.dts:49.24-25 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59053 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/616760e4/attachment-0001.gz>
