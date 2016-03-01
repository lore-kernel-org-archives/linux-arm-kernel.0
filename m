From: lkp@intel.com (kbuild test robot)
Date: Tue, 1 Mar 2016 23:13:19 +0800
Subject: [PATCH 1/2] ARM: dts: at91: sama5d2: add classD node
In-Reply-To: <ce1de34a6c36c17ce46bc39b675749c151aafad0.1456837347.git.nicolas.ferre@atmel.com>
Message-ID: <201603012330.j9rW3uaV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Songjun,

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on v4.5-rc6 next-20160301]
[cannot apply to at91/at91-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Nicolas-Ferre/ARM-dts-at91-sama5d2-add-classD-node/20160301-210755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36569 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160301/959274a8/attachment-0001.obj>
