From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 3 Oct 2017 09:52:08 +0800
Subject: [arm:for-next 9/11] awk: line 2: function strtonum never defined
Message-ID: <201710030905.zGRrw4dZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

FYI, the error/warning still remains.

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
head:   3cef8ede5ead55fbaf2225206f00361828adc3a1
commit: 887518f5e9963a82c3fc2ad8911eedb2304f8c57 [9/11] ARM: decompressor: fix BSS size calculation
config: arm-clps711x_defconfig (attached as .config)
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
--
>> awk: line 2: function strtonum never defined
>> awk: line 2: function strtonum never defined
   arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux': No such file

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 12371 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171003/dca33ac4/attachment-0001.gz>
