From: lkp@intel.com (kbuild test robot)
Date: Wed, 17 May 2017 18:41:54 +0800
Subject: [PATCH 2/3] arm64: dts: add LS1043A DPAA FMan support
In-Reply-To: <1494936443-14869-3-git-send-email-madalin.bucur@nxp.com>
Message-ID: <201705171805.DxANFDT3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Madalin,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.12-rc1 next-20170517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Madalin-Bucur/arm64-dts-add-DPAA-FMan-nodes/20170517-103731
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi:16.16-17 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34544 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170517/dc17e789/attachment-0001.gz>
