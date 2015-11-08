From: lkp@intel.com (kbuild test robot)
Date: Sun, 8 Nov 2015 21:42:11 +0800
Subject: [PATCH v3 10/10] arm64: dts: Enable the Thermal on R88 board
In-Reply-To: <1446974768-25795-11-git-send-email-wxt@rock-chips.com>
Message-ID: <201511082118.g4TUWjlz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

[auto build test ERROR on: soc-thermal/next]
[also build test ERROR on: next-20151106]
[cannot apply to: rockchip/for-next v4.3]

url:    https://github.com/0day-ci/linux/commits/Caesar-Wang/Better-compatible-for-the-rockchip-thermal-and-support-RK3368-SoCs/20151108-173308
base:   https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal next
config: arm64-defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/rockchip/rk3368-r88.dts:345.1-7 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 16486 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151108/4ab5abfa/attachment.obj>
