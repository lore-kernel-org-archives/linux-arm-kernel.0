From: lkp@intel.com (kbuild test robot)
Date: Tue, 3 Jul 2018 10:39:42 +0800
Subject: [PATCH 2/2] ARM: dts: pxa: add mioa701 board description
In-Reply-To: <20180702055733.18578-2-robert.jarzmik@free.fr>
References: <20180702055733.18578-2-robert.jarzmik@free.fr>
Message-ID: <201807031051.W2hlGCaM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.18-rc3 next-20180702]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Robert-Jarzmik/ARM-dts-pxa-add-pincontrol-helpers/20180702-140342
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-u8500_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22657 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180703/ed8da4d4/attachment-0001.gz>
