From: lkp@intel.com (kbuild test robot)
Date: Fri, 24 Jun 2016 10:18:35 +0800
Subject: [PATCH V2 2/4] STM Ftrace: Adding generic buffer interface driver
In-Reply-To: <1466563613-31578-3-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <201606241004.7obaz2yZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on tip/perf/core]
[also build test ERROR on v4.7-rc4 next-20160623]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chunyan-Zhang/Integration-of-function-trace-with-System-Trace-IP-blocks/20160622-115305
config: m68k-allyesconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `stm_ftrace_unlink':
>> ftrace.c:(.text+0x12197ac): undefined reference to `trace_rm_output'
   drivers/built-in.o: In function `stm_ftrace_link':
>> ftrace.c:(.text+0x12197be): undefined reference to `trace_add_output'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37199 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160624/e1718706/attachment-0001.obj>
