From: lkp@intel.com (kbuild test robot)
Date: Thu, 13 Jul 2017 08:25:56 +0800
Subject: [PATCH 3/3] ARM: dts: iwg20m: Add MMCIF0 support
In-Reply-To: <1499853805-5915-4-git-send-email-chris.paterson2@renesas.com>
Message-ID: <201707130850.0py1QazG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

[auto build test ERROR on renesas/next]
[also build test ERROR on next-20170712]
[cannot apply to v4.12]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chris-Paterson/Add-MMCIF0-support-for-r8a7743-iwg20m/20170713-042814
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/r8a7743-iwg20m.dtsi:40.1-5 Label or path pfc not found
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170713/a6646c4c/attachment-0001.gz>
