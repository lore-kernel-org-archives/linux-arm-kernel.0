From: lkp@intel.com (kbuild test robot)
Date: Sun, 5 Nov 2017 15:59:11 +0800
Subject: [PATCH V3 09/11] clk: sprd: add clocks support for SC9860
In-Reply-To: <20171102065626.21835-10-chunyan.zhang@spreadtrum.com>
References: <20171102065626.21835-10-chunyan.zhang@spreadtrum.com>
Message-ID: <201711051514.YPFNxHpn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chunyan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.14-rc7 next-20171103]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chunyan-Zhang/add-clock-driver-for-Spreadtrum-platforms/20171105-035536
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> ERROR: "sprd_clk_regmap_init" [drivers/clk/sprd/sc9860-clk.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57588 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171105/85c43202/attachment-0001.gz>
