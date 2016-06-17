From: lkp@intel.com (kbuild test robot)
Date: Sat, 18 Jun 2016 02:21:23 +0800
Subject: [PATCH 4/4] ARM: dts: meson8b: Add Meson8b PWM Controller nodes
In-Reply-To: <1466173784-15625-5-git-send-email-narmstrong@baylibre.com>
Message-ID: <201606180219.HabMMLCO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on next-20160617]
[cannot apply to pwm/for-next robh/for-next v4.7-rc3 v4.7-rc2 v4.7-rc1 v4.7-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Neil-Armstrong/pwm-Add-Amlogic-Meson-SoC-PWM-Controller/20160617-223758
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/meson8b.dtsi:167.17-18 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37970 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160618/1f7b4a03/attachment-0001.obj>
