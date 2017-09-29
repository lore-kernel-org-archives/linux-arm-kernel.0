From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 30 Sep 2017 03:05:25 +0800
Subject: [arm:for-next 9/10] awk: line 2: function strtonum never defined
Message-ID: <201709300322.kIz06Tci%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
head:   23b907cf143ec004c227fa2649c64d8e53f7fd2f
commit: 887518f5e9963a82c3fc2ad8911eedb2304f8c57 [9/10] ARM: decompressor: fix BSS size calculation
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 887518f5e9963a82c3fc2ad8911eedb2304f8c57
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> awk: line 2: function strtonum never defined
>> awk: line 2: function strtonum never defined

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23439 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170930/5902531b/attachment-0001.gz>
