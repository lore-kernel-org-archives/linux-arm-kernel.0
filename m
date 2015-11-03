From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 3 Nov 2015 23:07:05 +0800
Subject: [stericsson:earlydebug 1/1] undefined reference to `printascii'
Message-ID: <201511032304.jtSx8na2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git earlydebug
head:   92ab8295496c4d4c50cefce1c13863ce8eda7741
commit: 92ab8295496c4d4c50cefce1c13863ce8eda7741 [1/1] uglyhack printascii
config: i386-randconfig-a0-11022134 (attached as .config)
reproduce:
        git checkout 92ab8295496c4d4c50cefce1c13863ce8eda7741
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   init/built-in.o: In function `start_kernel':
>> (.init.text+0x616): undefined reference to `printascii'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23279 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151103/6f2be9c9/attachment-0001.obj>
