From: lkp@intel.com (kbuild test robot)
Date: Wed, 20 Sep 2017 08:27:17 +0800
Subject: [PATCH 2/2] tee: optee: allow selection of ti-smc as a calling
 method
In-Reply-To: <20170918205005.30235-2-afd@ti.com>
Message-ID: <201709200841.mja1RMta%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.14-rc1 next-20170919]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrew-F-Davis/ARM-smccc-call-Use-r12-to-route-secure-monitor-calls-on-TI-platforms/20170920-052543
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> ERROR: "arm_ti_smccc_smc" [drivers/tee/optee/optee.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57549 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170920/bc8005a8/attachment-0001.gz>
