From: lkp@intel.com (kbuild test robot)
Date: Sun, 26 Jun 2016 11:52:57 +0800
Subject: [PATCH v3 1/3] arm: tegra: initial support for apalis tk1
In-Reply-To: <1466298484-1098-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <201606261116.9IwjfA6i%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.7-rc4 next-20160624]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Marcel-Ziswiler/arm-tegra-initial-support-for-apalis-tk1/20160619-091204
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm-tegra_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   ERROR (duplicate_label): Duplicate label 'pinmux' on /pinmux at 70000868 and /pinmux at 0,70000868
>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 27896 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160626/1693511e/attachment-0001.obj>
