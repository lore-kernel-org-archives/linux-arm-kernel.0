From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Feb 2018 01:09:24 +0800
Subject: [PATCH] ARM: dts: da850-lcdk: add clock properties to the nand
 node
In-Reply-To: <20180205153204.20317-1-brgl@bgdev.pl>
References: <20180205153204.20317-1-brgl@bgdev.pl>
Message-ID: <201802080139.xpbqL9TL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.15 next-20180207]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/ARM-dts-da850-lcdk-add-clock-properties-to-the-nand-node/20180207-221912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
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
Size: 23404 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180208/03f55142/attachment-0001.gz>
