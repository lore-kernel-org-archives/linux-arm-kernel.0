From: lkp@intel.com (kbuild test robot)
Date: Sun, 2 Jul 2017 08:40:32 +0800
Subject: [PATCH v1 4/5] ARM: dts: stm32: Enable DCMI support on STM32F746
 MCU
In-Reply-To: <1498144371-13310-5-git-send-email-hugues.fruchet@st.com>
Message-ID: <201707020815.4xsrzMTU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hugues,

[auto build test ERROR on linuxtv-media/master]
[cannot apply to v4.12-rc7 next-20170630]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hugues-Fruchet/Camera-support-on-STM32F746G-DISCO-board/20170625-204425
base:   git://linuxtv.org/media_tree.git master
config: arm-spear6xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 14926 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170702/61b07578/attachment-0001.gz>
