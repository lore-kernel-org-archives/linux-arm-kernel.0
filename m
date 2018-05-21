From: lkp@intel.com (kbuild test robot)
Date: Mon, 21 May 2018 17:53:46 +0800
Subject: [xlnx:xlnx_rebase_v4.14 937/937]
 drivers/clk/idt/clk-idt8t49n24x-core.c:50:4: sparse: symbol 'q0_ns1_options'
 was not declared. Should it be static?
Message-ID: <201805211727.w7Yi11Xp%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   6588700bdabc9bb1a0156770ed2ac41da7d823dd
commit: 6588700bdabc9bb1a0156770ed2ac41da7d823dd [937/937] clk: Add ccf driver for IDT 8T49N24x UFT
reproduce:
        # apt-get install sparse
        git checkout 6588700bdabc9bb1a0156770ed2ac41da7d823dd
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/clk/idt/clk-idt8t49n24x-core.c:50:4: sparse: symbol 'q0_ns1_options' was not declared. Should it be static?
>> drivers/clk/idt/clk-idt8t49n24x-core.c:691:9: sparse: right shift by bigger than source value
   drivers/clk/idt/clk-idt8t49n24x-core.c:696:39: sparse: right shift by bigger than source value
--
>> drivers/clk/idt/clk-idt8t49n24x-debugfs.c:19:24: sparse: symbol 'idt24x_chip_fordebugfs' was not declared. Should it be static?
>> drivers/clk/idt/clk-idt8t49n24x-debugfs.c:246:47: sparse: dereference of noderef expression
   drivers/clk/idt/clk-idt8t49n24x-debugfs.c:247:32: sparse: dereference of noderef expression

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
