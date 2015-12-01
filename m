From: lkp@intel.com (kbuild test robot)
Date: Tue, 1 Dec 2015 23:56:40 +0800
Subject: [PATCH] reset: Introduce static inline dummy function when
 CONFIG_RESET_CONTROLLER
In-Reply-To: <1448984088-31904-1-git-send-email-nm@ti.com>
Message-ID: <201512012339.srrujPao%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

[auto build test ERROR on v4.4-rc3]
[also build test ERROR on next-20151127]

url:    https://github.com/0day-ci/linux/commits/Nishanth-Menon/reset-Introduce-static-inline-dummy-function-when-CONFIG_RESET_CONTROLLER/20151201-233708
config: i386-randconfig-n0-201548 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from drivers/reset/core.c:18:0:
>> include/linux/reset-controller.h:1:0: error: unterminated #ifndef
    #ifndef _LINUX_RESET_CONTROLLER_H_
    ^

vim +1 include/linux/reset-controller.h

61fc4131 Philipp Zabel 2012-11-19 @1  #ifndef _LINUX_RESET_CONTROLLER_H_
61fc4131 Philipp Zabel 2012-11-19  2  #define _LINUX_RESET_CONTROLLER_H_
61fc4131 Philipp Zabel 2012-11-19  3  
61fc4131 Philipp Zabel 2012-11-19  4  #include <linux/list.h>

:::::: The code at line 1 was first introduced by commit
:::::: 61fc41317666be400802ac793f47de816ef7bd57 reset: Add reset controller API

:::::: TO: Philipp Zabel <p.zabel@pengutronix.de>
:::::: CC: Philipp Zabel <p.zabel@pengutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 19727 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/b8cfedd7/attachment-0001.obj>
