From: lkp@intel.com (kbuild test robot)
Date: Tue, 21 Jun 2016 18:24:07 +0800
Subject: [PATCH 1/3] ARM: dts: rockchip: add i2s nodes for RK3228 SoCs
In-Reply-To: <1466493653-18611-2-git-send-email-zhengxing@rock-chips.com>
Message-ID: <201606211805.l80266mZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.7-rc4 next-20160621]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Xing-Zheng/ARM-dts-rockchip-add-i2s-nodes-for-RK3228-SoCs/20160621-152723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/rk3228.dtsi:249.29-30 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37700 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160621/5aa83d25/attachment-0001.obj>
