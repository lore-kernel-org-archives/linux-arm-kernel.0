From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 3 Nov 2015 22:58:21 +0800
Subject: [stericsson:earlydebug 1/1] main.c:undefined reference to `printascii'
Message-ID: <201511032219.HefUCe99%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git earlydebug
head:   92ab8295496c4d4c50cefce1c13863ce8eda7741
commit: 92ab8295496c4d4c50cefce1c13863ce8eda7741 [1/1] uglyhack printascii
config: mn10300-asb2364_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 92ab8295496c4d4c50cefce1c13863ce8eda7741
        # save the attached .config to linux build tree
        make.cross ARCH=mn10300 

All errors (new ones prefixed by >>):

   am33_2.0-linux-ld: Dwarf Error: mangled line number section.
   init/built-in.o: In function `.Loc.513.1':
>> main.c:(.init.text+0x38f): undefined reference to `printascii'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 8461 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151103/1baf6944/attachment-0001.obj>
