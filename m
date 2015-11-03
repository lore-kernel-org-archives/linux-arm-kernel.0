From: lkp@intel.com (kbuild test robot)
Date: Tue, 3 Nov 2015 18:21:48 +0800
Subject: [RESEND PATCH] ARM: errata: Workaround for Cortex-A12 erratum
 818325
In-Reply-To: <1446538209-13490-2-git-send-email-wxt@rock-chips.com>
Message-ID: <201511031801.GfWqzZ0v%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Huang,

[auto build test ERROR on mvebu/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Caesar-Wang/ARM-errata-Workaround-for-Cortex-A12-erratum-818325/20151103-163417
config: arm-prima2_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   /tmp/ccjF0uyl.s: Assembler messages:
>> /tmp/ccjF0uyl.s: Error: local label `"5" (instance number 1 of a fb label)' is not defined

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 12215 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151103/a7c6ec6c/attachment.obj>
