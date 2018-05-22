From: lkp@intel.com (kbuild test robot)
Date: Wed, 23 May 2018 03:28:03 +0800
Subject: [v4 05/11] ARM: dts: aspeed: peci: Add PECI node
In-Reply-To: <20180521195846.27894-1-jae.hyun.yoo@linux.intel.com>
References: <20180521195846.27894-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <201805230247.9v9rdyqS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jae,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jae-Hyun-Yoo/dt-bindings-Add-a-document-of-PECI-subsystem/20180522-204411
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed-g5.dtsi:382.21-22 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm/boot/dts/aspeed-g4.dtsi:332.21-22 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64516 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180523/8f62f1c8/attachment-0001.gz>
