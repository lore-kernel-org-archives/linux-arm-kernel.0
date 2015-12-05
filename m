From: lkp@intel.com (kbuild test robot)
Date: Sat, 5 Dec 2015 20:53:07 +0800
Subject: [PATCH RESEND net-next 1/3] dts: hisi: enables the ethX for D02
 board
In-Reply-To: <1449302218-54374-2-git-send-email-yankejian@huawei.com>
Message-ID: <201512052010.fCqOAE0r%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi yankejian,

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/yankejian/dts-hisi-fixes-can-t-find-eth-for-hip05-D02/20151205-155412
config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/hisilicon/hip05-d02.dts:38.1-6 Label or path eth2 not found
>> Error: arch/arm64/boot/dts/hisilicon/hip05-d02.dts:42.1-6 Label or path eth3 not found
>> Error: arch/arm64/boot/dts/hisilicon/hip05-d02.dts:46.1-6 Label or path eth6 not found
>> Error: arch/arm64/boot/dts/hisilicon/hip05-d02.dts:50.1-6 Label or path eth7 not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 46778 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151205/05ddaa35/attachment-0001.obj>
