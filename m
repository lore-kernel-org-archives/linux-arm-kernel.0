From: lkp@intel.com (kbuild test robot)
Date: Wed, 1 Aug 2018 08:45:35 +0800
Subject: [PATCH v4 5/5] arm64: dts: actions: Add pinctrl node for Actions
 Semi S700
In-Reply-To: <20180731194743.13678-6-sravanhome@gmail.com>
References: <20180731194743.13678-6-sravanhome@gmail.com>
Message-ID: <201808010805.DWcXxX04%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravanan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pinctrl/devel]
[also build test ERROR on next-20180731]
[cannot apply to v4.18-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Saravanan-Sekar/pinctrl-actions-define-constructor-generic-to-Actions-Semi-SoC-s/20180801-042834
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/actions/s700.dtsi:172.19-20 syntax error
>> FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38876 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180801/90058689/attachment-0001.gz>
