From: lkp@intel.com (kbuild test robot)
Date: Sun, 30 Sep 2018 10:04:18 +0800
Subject: [PATCH v2 1/3] arm64: dts: actions: s900: Enable Tx DMA for UART5
In-Reply-To: <20180929074637.9766-2-manivannan.sadhasivam@linaro.org>
References: <20180929074637.9766-2-manivannan.sadhasivam@linaro.org>
Message-ID: <201809301043.z0Y7bpfe%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manivannan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on v4.19-rc5 next-20180928]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Manivannan-Sadhasivam/Add-slave-DMA-support-for-Actions-Semi-S900-SoC/20180929-155016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 40255 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180930/a569519f/attachment-0001.gz>
