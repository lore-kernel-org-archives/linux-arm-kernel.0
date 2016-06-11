From: lkp@intel.com (kbuild test robot)
Date: Sat, 11 Jun 2016 08:14:13 +0800
Subject: [PATCH 48/48] ARM: dts: at91: kizbox: switch to new
 pwm-atmel-tcb binding
In-Reply-To: <1465596231-21766-49-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <201606110839.HwBLqerx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on at91/at91-next]
[also build test ERROR on v4.7-rc2 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexandre-Belloni/ARM-at91-rework-Atmel-TCB-drivers/20160611-062134
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git at91-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/at91-kizbox.dts:54.5-15 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21096 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160611/15668201/attachment-0001.obj>
