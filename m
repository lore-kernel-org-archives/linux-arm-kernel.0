From: lkp@intel.com (kbuild test robot)
Date: Wed, 27 Jun 2018 14:06:12 +0800
Subject: [PATCH 2/2] clk: actions: Add S700 SoC clock support
In-Reply-To: <20180626192820.28237-3-sravanhome@gmail.com>
References: <20180626192820.28237-3-sravanhome@gmail.com>
Message-ID: <201806271319.HFilExN1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravanan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.18-rc2 next-20180626]
[cannot apply to robh/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Saravanan-Sekar/Add-clock-driver-for-Actions-S700-SoC/20180627-033122
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.data+0x36aa88): Section mismatch in reference from the variable __compound_literal.97 to the variable .init.rodata:__setup_str_initcall_blacklist
   The variable __compound_literal.97 references
   the variable __initconst __setup_str_initcall_blacklist
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54027 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180627/3518769b/attachment-0001.gz>
