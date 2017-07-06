From: lkp@intel.com (kbuild test robot)
Date: Thu, 6 Jul 2017 14:47:50 +0800
Subject: [PATCH v2 3/6] ARM: dts: rockchip: enable io-domain for rk3229-evb
In-Reply-To: <1499243421-21460-4-git-send-email-frank.wang@rock-chips.com>
Message-ID: <201707061400.5K7lBcIR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

[auto build test ERROR on rockchip/for-next]
[cannot apply to v4.12]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Frank-Wang/ARM-dts-rockchip-add-regulator-nodes-for-rk3229-evb/20170706-094621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/rk3229-evb.dts:164.1-12 Label or path io_domains not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22761 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170706/fe182922/attachment-0001.gz>
