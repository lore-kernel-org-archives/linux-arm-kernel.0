From: lkp@intel.com (kbuild test robot)
Date: Fri, 20 Apr 2018 00:59:56 +0800
Subject: [PATCH] ARM: dts: stm32: Add DAC support to stm32mp157c
In-Reply-To: <1524066391-843-1-git-send-email-fabrice.gasnier@st.com>
References: <1524066391-843-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <201804200028.0gjXoP1P%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.17-rc1 next-20180419]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Fabrice-Gasnier/ARM-dts-stm32-Add-DAC-support-to-stm32mp157c/20180419-211311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-moxart_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/stm32mp157c.dtsi:165.19-20 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 12322 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/c4a615c0/attachment.gz>
