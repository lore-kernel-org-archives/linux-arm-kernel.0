From: lkp@intel.com (kbuild test robot)
Date: Wed, 2 Mar 2016 02:37:14 +0800
Subject: [PATCH 3/6] powerpc: rtc: provide rtc_class_ops directly
In-Reply-To: <1456851608-3374907-4-git-send-email-arnd@arndb.de>
Message-ID: <201603020228.jios50eU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on v4.5-rc6 next-20160301]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/rtc-generic-follow-up-for-COMPILE_TEST/20160302-011032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: powerpc-allnoconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/built-in.o: In function `rtc_generic_get_time':
>> time.c:(.text+0x4c58): undefined reference to `rtc_valid_tm'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 5708 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160302/fb4fdc17/attachment.obj>
