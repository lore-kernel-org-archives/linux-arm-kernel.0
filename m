From: lkp@intel.com (kbuild test robot)
Date: Mon, 4 Jul 2016 09:15:36 +0800
Subject: [PATCH] clkdev: add devm_of_clk_get()
In-Reply-To: <87y45iz0cs.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <201607040929.BqJXQ3tc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.7-rc5 next-20160701]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kuninori-Morimoto/clkdev-add-devm_of_clk_get/20160704-090653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: i386-tinyconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   arch/x86/kernel/tsc.o: In function `devm_of_clk_get':
>> tsc.c:(.text+0x3e0): multiple definition of `devm_of_clk_get'
   arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 6328 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160704/ebb87313/attachment.obj>
