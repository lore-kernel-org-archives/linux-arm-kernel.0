From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Oct 2015 04:33:23 +0800
Subject: [PATCH v1 3/3] ARM64: dts: rk3368: Add mailbox device nodes
In-Reply-To: <1445931106-683-4-git-send-email-wxt@rock-chips.com>
Message-ID: <201510280433.KeMm1w9H%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

[auto build test ERROR on rockchip/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Caesar-Wang/mailbox-rockchip-Add-mailbox-driver-for-Rockchip-platform/20151027-153608
config: arm64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/rockchip/rk3368.dtsi:490.3-4 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45779 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151028/fbf01d30/attachment-0001.obj>
