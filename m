From: lkp@intel.com (kbuild test robot)
Date: Wed, 14 Feb 2018 09:04:00 +0800
Subject: [PATCH v2 3/5] [RFT] ARM: dts: wheat: Fix ADV7513 address usage
In-Reply-To: <1518459117-16733-4-git-send-email-kbingham@kernel.org>
References: <1518459117-16733-4-git-send-email-kbingham@kernel.org>
Message-ID: <201802140855.gCf9wb3G%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kieran,

I love your patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.16-rc1 next-20180213]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kieran-Bingham/dt-bindings-media-adv7604-Add-support-for-i2c_new_secondary_device/20180214-032943
base:   git://linuxtv.org/media_tree.git master
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/r8a7792-wheat.dts:251.24-25 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63980 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180214/710eeca4/attachment-0001.gz>
