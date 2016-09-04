From: lkp@intel.com (kbuild test robot)
Date: Sun, 4 Sep 2016 20:04:30 +0800
Subject: [PATCH 4/4] ARM: dts: use definition in rockchip pinctrl header
 to describe gpios on Popmetal-RK3288
In-Reply-To: <1472978177-970-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <201609042016.JNe65VGp%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.8-rc4 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Andy-Yan/One-fix-and-some-improvements-for-RK3288-Popmetal-board/20160904-164007
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-aspeed_g4_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/rk3288-popmetal.dts:131.18-19 syntax error
>> FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 7602 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160904/6c34202a/attachment-0001.obj>
