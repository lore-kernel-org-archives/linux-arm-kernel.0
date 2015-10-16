From: lkp@intel.com (kbuild test robot)
Date: Sat, 17 Oct 2015 04:49:29 +0800
Subject: [PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
In-Reply-To: <1445012530-14126-10-git-send-email-balbi@ti.com>
Message-ID: <201510170412.4siQMwFD%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

[auto build test ERROR on omap/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Felipe-Balbi/arm-omap-timer-cleanups/20151017-002649
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `ti_32k_timer_init':
>> timer-ti-32k.c:(.init.text+0x213a6): undefined reference to `sched_clock_register'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51600 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151017/da6f5f3e/attachment-0001.obj>
