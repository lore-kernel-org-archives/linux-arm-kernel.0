From: lkp@intel.com (kbuild test robot)
Date: Sun, 13 Aug 2017 19:03:20 +0800
Subject: [PATCH v5 09/11] ARM: dts: rk3228-evb: Enable the integrated PHY
 for gmac
In-Reply-To: <1502373668-2767-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <201708131835.mxp4Bgpb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

[auto build test ERROR on net/master]
[also build test ERROR on v4.13-rc4 next-20170811]
[cannot apply to net-next/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/David-Wu/Add-the-integrated-PHY-support/20170813-163538
config: arm-omap2plus_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30001 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170813/51d7c864/attachment-0001.gz>
