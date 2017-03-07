From: lkp@intel.com (kbuild test robot)
Date: Tue, 7 Mar 2017 14:50:47 +0800
Subject: [PATCH V10 5/6] ARM64: dts: bcm2837: Define CPU thermal
 coefficients
In-Reply-To: <1488583129-4159-6-git-send-email-stefan.wahren@i2se.com>
Message-ID: <201703071405.aMV4Et3y%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

[auto build test ERROR on thermal/next]
[also build test ERROR on v4.11-rc1]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stefan-Wahren/thermal-bcm2835-add-thermal-driver-for-bcm2835-SoC/20170307-065051
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/broadcom/bcm2837.dtsi:83.1-9 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53565 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170307/5e0cd9e8/attachment-0001.gz>
