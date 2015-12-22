From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 22 Dec 2015 13:08:26 +0800
Subject: [arm:for-next 20/25] /tmp/ccMMP9pi.s:67: Error: selected processor
 does not support ARM mode `isb'
Message-ID: <201512221324.RTacS2Z7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git for-next
head:   952b96ba23e34ebe3ebef561336986005f3d8425
commit: 9afc4686531bf701670f329217b8b044ccd95297 [20/25] ARM: 8452/2: PJ4: make coprocessor access sequences buildable in Thumb2 mode
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9afc4686531bf701670f329217b8b044ccd95297
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   /tmp/ccMMP9pi.s: Assembler messages:
>> /tmp/ccMMP9pi.s:67: Error: selected processor does not support ARM mode `isb'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54598 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151222/f7da7890/attachment-0001.obj>
