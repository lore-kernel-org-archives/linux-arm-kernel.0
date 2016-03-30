From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 30 Mar 2016 16:59:36 +0800
Subject: [stericsson:earlydebug 1/1] undefined reference to `printascii'
Message-ID: <201603301634.NZINzh2u%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git earlydebug
head:   7a0e86123c84ec8853d7c6ae248e911a04a81bb4
commit: 7a0e86123c84ec8853d7c6ae248e911a04a81bb4 [1/1] uglyhack printascii
config: i386-randconfig-n0-201613 (attached as .config)
reproduce:
        git checkout 7a0e86123c84ec8853d7c6ae248e911a04a81bb4
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   init/built-in.o: In function `start_kernel':
>> (.init.text+0x45a): undefined reference to `printascii'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21634 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160330/4ce4d522/attachment-0001.obj>
