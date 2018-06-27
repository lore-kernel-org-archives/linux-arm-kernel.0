From: lkp@intel.com (kbuild test robot)
Date: Wed, 27 Jun 2018 14:06:11 +0800
Subject: [PATCH 2/2] clk: actions: Add S700 SoC clock support
In-Reply-To: <20180626192820.28237-3-sravanhome@gmail.com>
References: <20180626192820.28237-3-sravanhome@gmail.com>
Message-ID: <201806271221.P3PVZd5m%fengguang.wu@intel.com>
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
config: x86_64-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.data+0x185d9b0): Section mismatch in reference from the variable __compound_literal.97 to the variable .init.rodata:sensor_clk_mux_p
   The variable __compound_literal.97 references
   the variable __initconst sensor_clk_mux_p
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: vmlinux.o(.data+0x185dbb0): Section mismatch in reference from the variable __compound_literal.94 to the variable .init.rodata:i2s_clk_mux_p
   The variable __compound_literal.94 references
   the variable __initconst i2s_clk_mux_p
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: vmlinux.o(.data+0x185e390): Section mismatch in reference from the variable __compound_literal.85 to the variable .init.rodata:pwm_clk_mux_p
   The variable __compound_literal.85 references
   the variable __initconst pwm_clk_mux_p
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: vmlinux.o(.data+0x185e550): Section mismatch in reference from the variable __compound_literal.83 to the variable .init.rodata:uart_clk_mux_p
   The variable __compound_literal.83 references
   the variable __initconst uart_clk_mux_p
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: vmlinux.o(.data+0x185eb70): Section mismatch in reference from the variable __compound_literal.76 to the variable .init.rodata:sd_clk_mux_p
   The variable __compound_literal.76 references
   the variable __initconst sd_clk_mux_p
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: vmlinux.o(.data+0x185ee10): Section mismatch in reference from the variable __compound_literal.73 to the variable .init.rodata:nand_clk_mux_p
   The variable __compound_literal.73 references
   the variable __initconst nand_clk_mux_p
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: vmlinux.o(.data+0x185eef0): Section mismatch in reference from the variable __compound_literal.72 to the variable .init.rodata:hde_clk_mux_p
   The variable __compound_literal.72 references
   the variable __initconst hde_clk_mux_p
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: vmlinux.o(.data+0x185f190): Section mismatch in reference from the variable __compound_literal.69 to the variable .init.rodata:de_clk_mux_p
   The variable __compound_literal.69 references
   the variable __initconst de_clk_mux_p
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: vmlinux.o(.data+0x185f270): Section mismatch in reference from the variable __compound_literal.68 to the variable .init.rodata:csi_clk_mux_p
   The variable __compound_literal.68 references
   the variable __initconst csi_clk_mux_p
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: vmlinux.o(.data+0x1861890): Section mismatch in reference from the variable __compound_literal.12 to the variable .init.rodata:noc_clk_mux_p
   The variable __compound_literal.12 references
   the variable __initconst noc_clk_mux_p
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: vmlinux.o(.data+0x1861ad0): Section mismatch in reference from the variable __compound_literal.9 to the variable .init.rodata:dev_clk_p
   The variable __compound_literal.9 references
   the variable __initconst dev_clk_p
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
..

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64006 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180627/27feb412/attachment-0001.gz>
