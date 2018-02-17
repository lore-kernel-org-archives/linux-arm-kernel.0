From: lkp@intel.com (kbuild test robot)
Date: Sun, 18 Feb 2018 06:58:04 +0800
Subject: [PATCH 3/3] ARM: dts: stm32: Add display support on
 stm32f469-disco
In-Reply-To: <20180215082014.30383-4-philippe.cornu@st.com>
References: <20180215082014.30383-4-philippe.cornu@st.com>
Message-ID: <201802180643.kCQcZb3Z%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.16-rc1 next-20180216]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Philippe-Cornu/ARM-dts-stm32-Add-display-support-on-stm32f469-disco/20180218-052546
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/stm32f469.dtsi:14.21-22 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23600 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180218/8e12c2c1/attachment-0001.gz>
