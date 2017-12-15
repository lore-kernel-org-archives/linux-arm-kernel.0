From: lkp@intel.com (kbuild test robot)
Date: Fri, 15 Dec 2017 11:56:31 +0800
Subject: [PATCH] arm64: allwinner: a64: a64-olinuxino: add usb otg
In-Reply-To: <1513058169-25516-1-git-send-email-jagan@amarulasolutions.com>
References: <1513058169-25516-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <201712151116.lSc3QGK5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jagan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.15-rc3]
[cannot apply to next-20171214]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jagan-Teki/arm64-allwinner-a64-a64-olinuxino-add-usb-otg/20171215-084728
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts:204.1-15 Label or path reg_drivevbus not found
>> FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37312 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171215/86724236/attachment-0001.gz>
