From: lkp@intel.com (kbuild test robot)
Date: Fri, 22 Jul 2016 06:08:54 +0800
Subject: [PATCH v5 3/3] arm: dts: mt2701: Add auxadc node.
In-Reply-To: <1469085449-22679-4-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <201607220639.0tIT3cRj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.7-rc7 next-20160721]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Zhiyong-Tao/AUXADC-Mediatek-auxadc-driver/20160722-041141
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/mt2701.dtsi:145.22-23 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21319 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160722/d4a5fbee/attachment-0001.obj>
