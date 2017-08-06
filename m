From: lkp@intel.com (kbuild test robot)
Date: Sun, 6 Aug 2017 13:25:21 +0800
Subject: [PATCH] ARM64: dts: meson-gx: Use correct mmc clock source 0
In-Reply-To: <20170731120552.31606-1-jbrunet@baylibre.com>
Message-ID: <201708061316.vyrWnnKm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.13-rc3 next-20170804]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jerome-Brunet/ARM64-dts-meson-gx-Use-correct-mmc-clock-source-0/20170801-002221
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi:655.11-12 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm64/boot/dts/amlogic/meson-gxl.dtsi:596.11-12 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56922 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170806/127e1b70/attachment-0001.gz>
