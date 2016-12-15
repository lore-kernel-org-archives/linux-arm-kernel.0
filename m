From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Dec 2016 18:28:58 +0800
Subject: [PATCH 6/6] watchdog: ts4600: add driver for TS-4600 watchdog
In-Reply-To: <20161214231237.17496-7-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <201612151847.aVsOJIuu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastien,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9]
[cannot apply to next-20161215]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sebastien-Bourdelin/of-documentation-add-bindings-documentation-for-TS-4600/20161215-072238
config: i386-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `ts4600_wdt_start':
>> ts4600_wdt.c:(.text+0x2333d64): undefined reference to `ts_nbus_write'
   drivers/built-in.o: In function `ts4600_wdt_stop':
   ts4600_wdt.c:(.text+0x2333d85): undefined reference to `ts_nbus_write'
   drivers/built-in.o: In function `ts4600_wdt_probe':
   ts4600_wdt.c:(.text+0x2333e66): undefined reference to `ts_nbus_write'
>> ts4600_wdt.c:(.text+0x2333ee9): undefined reference to `ts_nbus_is_ready'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57052 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161215/7129c152/attachment-0001.gz>
