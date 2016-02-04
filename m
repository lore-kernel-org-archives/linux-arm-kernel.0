From: lkp@intel.com (kbuild test robot)
Date: Thu, 4 Feb 2016 09:34:07 +0800
Subject: [PATCH 7/8] ARM: dts: rockchip: enable the tsadc for rk3228 evb
In-Reply-To: <1454472767-5767-8-git-send-email-wxt@rock-chips.com>
Message-ID: <201602040923.uH3zLqrT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.5-rc2 next-20160203]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Caesar-Wang/Support-and-fixes-the-rk3228-SoCS-for-thermal/20160203-121829
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Caesar-Wang/Support-and-fixes-the-rk3228-SoCS-for-thermal/20160203-121829 HEAD 661e15b9e9c05d7a350ca8928be2b89e5c36b4d6 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/rk3228-evb.dts:64.1-7 Label or path tsadc not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36561 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160204/e1d7595f/attachment-0001.obj>
