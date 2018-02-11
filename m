From: lkp@intel.com (kbuild test robot)
Date: Sun, 11 Feb 2018 13:06:04 +0800
Subject: [PATCH] ARM: dts: da850-evm: add clock properties to the nand node
In-Reply-To: <20180205155222.22189-1-brgl@bgdev.pl>
References: <20180205155222.22189-1-brgl@bgdev.pl>
Message-ID: <201802111325.SE0T4030%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.15 next-20180209]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/ARM-dts-da850-evm-add-clock-properties-to-the-nand-node/20180208-105626
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-sunxi_defconfig (attached as .config)
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
Size: 23273 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180211/5feae002/attachment-0001.gz>
