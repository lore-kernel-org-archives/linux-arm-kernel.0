From: lkp@intel.com (kbuild test robot)
Date: Mon, 5 Sep 2016 10:35:54 +0800
Subject: [PATCH v2] ARM: dts: sun8i: Add dts file for the NanoPi NEO SBC
In-Reply-To: <1473036168-20933-1-git-send-email-james@innovum.com.au>
Message-ID: <201609051025.IbTHt9ri%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

[auto build test ERROR on mripard/sunxi/for-next]
[also build test ERROR on v4.8-rc5 next-20160825]
[cannot apply to robh/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/James-Pettigrew/ARM-dts-sun8i-Add-dts-file-for-the-NanoPi-NEO-SBC/20160905-085509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git sunxi/for-next
config: arm-aspeed_g5_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts:65.21-22 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 7654 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/d12c98bc/attachment-0001.obj>
