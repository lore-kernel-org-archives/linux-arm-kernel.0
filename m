From: lkp@intel.com (kbuild test robot)
Date: Sat, 1 Sep 2018 19:43:15 +0800
Subject: [PATCH v5 2/2] clk: Add functions to get optional clocks
In-Reply-To: <1535724443-21150-3-git-send-email-phil.edworthy@renesas.com>
References: <1535724443-21150-3-git-send-email-phil.edworthy@renesas.com>
Message-ID: <201809011734.dCcCNJQY%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Phil,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.19-rc1 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Phil-Edworthy/clk-Add-functions-to-get-optional-clocks/20180901-154009
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: m68k-m5475evb_defconfig (attached as .config)
compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=m68k 

All errors (new ones prefixed by >>):

   drivers/clk/clk-devres.o: In function `__devm_clk_get':
>> clk-devres.c:(.text+0xb6): undefined reference to `clk_get_optional'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6371 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180901/6e5bc2a0/attachment.gz>
