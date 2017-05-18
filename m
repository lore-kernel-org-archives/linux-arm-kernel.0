From: lkp@intel.com (kbuild test robot)
Date: Thu, 18 May 2017 11:18:17 +0800
Subject: [PATCH 3/3] arm: dts: rk322x: add watchdog device node.
In-Reply-To: <1494992451-32542-4-git-send-email-frank.wang@rock-chips.com>
Message-ID: <201705181148.b4AgD8sU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.12-rc1 next-20170517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Frank-Wang/add-and-fix-some-device-node-for-rk322x-SoC/20170518-081958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/rk322x.dtsi:286.18-19 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22761 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170518/62057d73/attachment-0001.gz>
