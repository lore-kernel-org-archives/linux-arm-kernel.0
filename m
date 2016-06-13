From: lkp@intel.com (kbuild test robot)
Date: Mon, 13 Jun 2016 20:43:19 +0800
Subject: [PATCH] ARM: sun8i: Add Parrot Board DTS
In-Reply-To: <1465812931-22824-2-git-send-email-quentin.schulz@free-electrons.com>
Message-ID: <201606132024.ObwKj3uN%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.7-rc3 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Quentin-Schulz/ARM-sun8i-Add-Parrot-Board-DTS/20160613-181947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/sun8i-r16-parrot.dts:285.1-15 Label or path reg_drivevbus not found
>> FATAL ERROR: Syntax error parsing input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 19879 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160613/7776e70c/attachment-0001.obj>
