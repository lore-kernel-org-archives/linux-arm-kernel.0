From: lkp@intel.com (kbuild test robot)
Date: Mon, 17 Jul 2017 21:10:47 +0800
Subject: [PATCH 05/11] mmc: sunxi: Support controllers that can use both
 old and new timings
In-Reply-To: <20170714064302.20383-6-wens@csie.org>
Message-ID: <201707172131.gWlKt3Lf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.13-rc1]
[cannot apply to robh/for-next clk/clk-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chen-Yu-Tsai/ARM-sun8i-a83t-Add-support-for-MMC-controllers/20170715-071008
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> ERROR: "sunxi_ccu_set_mmc_timing_mode" [drivers/mmc/host/sunxi-mmc.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56606 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/ed3302ce/attachment-0001.gz>
