From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Mar 2018 09:11:50 +0800
Subject: [PATCH] ARM64: dts: meson-axg: add saradc support
In-Reply-To: <20180326092117.208416-1-yixun.lan@amlogic.com>
References: <20180326092117.208416-1-yixun.lan@amlogic.com>
Message-ID: <201803270741.hpZ3d2Fr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xingyu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20180326]
[cannot apply to robh/for-next v4.16-rc7 v4.16-rc6 v4.16-rc5 v4.16-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yixun-Lan/ARM64-dts-meson-axg-add-saradc-support/20180326-233815
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/amlogic/meson-axg.dtsi:810.16-17 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37376 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180327/2fafa237/attachment-0001.gz>
