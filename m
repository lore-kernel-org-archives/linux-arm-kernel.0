From: lkp@intel.com (kbuild test robot)
Date: Sun, 18 Jun 2017 08:31:19 +0800
Subject: [PATCH v2 3/5] arm64: dts: Add ufs dts node
In-Reply-To: <20170616065119.10704-4-butao@hisilicon.com>
Message-ID: <201706180814.Kte2462z%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bu,

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on v4.12-rc5 next-20170616]
[cannot apply to robh/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bu-Tao/scsi-ufs-add-ufs-driver-code-for-Hi3660-SoC/20170618-045141
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/hisilicon/hi3660.dtsi:152.24-25 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35380 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170618/2225e152/attachment-0001.gz>
