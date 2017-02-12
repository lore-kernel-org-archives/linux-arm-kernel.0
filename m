From: lkp@intel.com (kbuild test robot)
Date: Sun, 12 Feb 2017 17:17:46 +0800
Subject: [PATCH] ARM: dts: sun5i-gr8: Rename pwm0_pins_a to pwm0_pins
In-Reply-To: <20170210034234.3612-1-wens@csie.org>
Message-ID: <201702121759.13cBv97u%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.10-rc7 next-20170210]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chen-Yu-Tsai/ARM-dts-sun5i-gr8-Rename-pwm0_pins_a-to-pwm0_pins/20170210-122740
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
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
Size: 59747 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170212/f25cf3f2/attachment-0001.gz>
