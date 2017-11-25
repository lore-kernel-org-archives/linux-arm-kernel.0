From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 25 Nov 2017 20:36:51 +0800
Subject: [arm:to-build 13/13] traps.c:undefined reference to
 `__entry_text_start'
Message-ID: <201711252049.w8dC2JRI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git to-build
head:   48396f69d33e020614c48b3fca870f6f24144b61
commit: 48396f69d33e020614c48b3fca870f6f24144b61 [13/13] ARM: probes: avoid adding kprobes to sensitive kernel-entry/exit code
config: arm-efm32_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 48396f69d33e020614c48b3fca870f6f24144b61
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kernel/traps.o: In function `dump_backtrace_entry':
>> traps.c:(.text+0xd4): undefined reference to `__entry_text_start'
>> traps.c:(.text+0xd8): undefined reference to `__entry_text_end'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 11467 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171125/c46bc46e/attachment-0001.gz>
