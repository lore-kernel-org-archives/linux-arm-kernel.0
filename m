From: lkp@intel.com (kbuild test robot)
Date: Sun, 12 Aug 2018 09:23:07 +0800
Subject: [PATCH 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
In-Reply-To: <20180808224701.7527-3-jcrouse@codeaurora.org>
References: <20180808224701.7527-3-jcrouse@codeaurora.org>
Message-ID: <201808120903.eouXQvf0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jordan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robclark/msm-next]
[also build test ERROR on v4.18-rc8 next-20180810]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jordan-Crouse/arm64-dts-Add-sdm845-GPU-GMU-and-SMMU/20180811-082810
base:   git://people.freedesktop.org/~robclark/linux msm-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/sdm845.dtsi:342.25-26 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38795 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180812/a4aafbe1/attachment-0001.gz>
