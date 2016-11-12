From: lkp@intel.com (kbuild test robot)
Date: Sun, 13 Nov 2016 07:51:49 +0800
Subject: [PATCH 10/10] ARM: gr8: Convert to CCU
In-Reply-To: <14a9d0306074ca0276831dc42104929a65f3b666.1478625788.git-series.maxime.ripard@free-electrons.com>
Message-ID: <201611130734.k6XLPbXV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

[auto build test ERROR on ]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/ARM-sun5i-Convert-sun5i-SoCs-to-sunxi-ng/20161109-014935
base:    
config: arm-pxa168_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
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
Size: 11419 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161113/b504f40e/attachment-0001.gz>
