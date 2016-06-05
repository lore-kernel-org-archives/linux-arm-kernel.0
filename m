From: lkp@intel.com (kbuild test robot)
Date: Sun, 5 Jun 2016 08:51:08 +0800
Subject: [PATCH v3 1/2] ARM: dts: sun9i: a80-optimus: Drop
 sunxi-common-regulators.dtsi
In-Reply-To: <1464936651-25911-2-git-send-email-wens@csie.org>
Message-ID: <201606050804.et1AHYz0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.7-rc1 next-20160603]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chen-Yu-Tsai/ARM-dts-sun9i-a80-optimus-Drop-sunxi-common-regulators-dtsi/20160603-145402
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
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
Type: application/octet-stream
Size: 37214 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160605/9edc95c4/attachment-0001.obj>
