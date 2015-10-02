From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Oct 2015 02:28:40 +0800
Subject: [PATCH v4 3/3] arm64: dts: mt8173: add timer node
In-Reply-To: <1443798319-45744-4-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <201510030200.jT6J0xbF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: arm64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/mediatek/mt8173.dtsi:246.24-25 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151003/5a50e32c/attachment-0001.obj>
