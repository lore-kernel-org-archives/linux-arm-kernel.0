From: lkp@intel.com (kbuild test robot)
Date: Thu, 24 Dec 2015 03:52:39 +0800
Subject: [PATCH 4/4] ARM: dts: rockchip: Add support emac for RK3036
In-Reply-To: <1450862390-407-4-git-send-email-zhengxing@rock-chips.com>
Message-ID: <201512240333.QnElWSVi%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xing,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on next-20151223]
[cannot apply to v4.4-rc6]

url:    https://github.com/0day-ci/linux/commits/Xing-Zheng/net-ethernet-arc-Probe-emac-after-set-RMII-clock/20151223-172442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/rk3036.dtsi:196.18-19 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54588 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151224/15bfefee/attachment-0001.obj>
