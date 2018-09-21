From: lkp@intel.com (kbuild test robot)
Date: Fri, 21 Sep 2018 11:44:28 +0800
Subject: [PATCH] ARM: dts: sun8i: sun8i-h3-nanopi-m1-plus: enable HDMI
 output
In-Reply-To: <1537388051-39623-1-git-send-email-clabbe@baylibre.com>
References: <1537388051-39623-1-git-send-email-clabbe@baylibre.com>
Message-ID: <201809211122.bl4kKBDW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin,

I love your patch! Yet something to improve:

[auto build test ERROR on sunxi/sunxi/for-next]
[also build test ERROR on v4.19-rc4 next-20180919]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Corentin-Labbe/ARM-dts-sun8i-sun8i-h3-nanopi-m1-plus-enable-HDMI-output/20180920-165643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
config: arm-oxnas_v6_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts:120.2-18 Properties must precede subnodes
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 15051 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180921/d6ced42f/attachment-0001.gz>
