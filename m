From: lkp@intel.com (kbuild test robot)
Date: Thu, 29 Oct 2015 21:35:42 +0800
Subject: [PATCH] recordmcount: arm64: replace the ignored mcount call
 into nop
In-Reply-To: <1446019445-14421-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <201510292118.ZYBYzBGa%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Li,

[auto build test ERROR on arm64/for-next/core -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Li-Bin/recordmcount-arm64-replace-the-ignored-mcount-call-into-nop/20151028-160846
config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> /bin/bash: line 1: 117734 Segmentation fault      ./scripts/recordmcount "arch/arm64/kernel/traps.o"
--
>> /bin/bash: line 1: 113824 Segmentation fault      ./scripts/recordmcount "arch/arm64/mm/fault.o"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45574 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151029/469c95e2/attachment-0001.obj>
