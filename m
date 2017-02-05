From: lkp@intel.com (kbuild test robot)
Date: Sun, 5 Feb 2017 09:41:25 +0800
Subject: [PATCH v4 6/8] ARM: dts: sun8i: Add audio codec, dai and card
 for A33
In-Reply-To: <20170202092422.5588-7-mylene.josserand@free-electrons.com>
Message-ID: <201702050904.X9UcHCka%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Myl?ne,

[auto build test ERROR on asoc/for-next]
[also build test ERROR on v4.10-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/Add-sun8i-A33-audio-driver/20170202-173022
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: arm-vf610m4_defconfig (attached as .config)
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
Size: 8318 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170205/0afb3071/attachment-0001.gz>
