From: lkp@intel.com (kbuild test robot)
Date: Thu, 25 Aug 2016 17:28:58 +0800
Subject: [PATCH v2 6/7] arm64: dts: exynos: Add dts file for
 Exynos5433-based TM2 board
In-Reply-To: <1472046551-703-7-git-send-email-cw00.choi@samsung.com>
Message-ID: <201608251736.gveyTsas%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.8-rc3 next-20160824]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Chanwoo-Choi/arm64-dts-Add-the-dts-file-for-Exynos5433-and-TM-TM2E-board/20160824-215757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/Chanwoo-Choi/arm64-dts-Add-the-dts-file-for-Exynos5433-and-TM-TM2E-board/20160824-215757 HEAD 46d1185173dccb3ecf3c7b36a713e8eee1d39cfe builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> make[3]: *** No rule to make target 'arch/arm64/boot/dts/exynos/exynos5433-tm2e.dtb', needed by '__build'.
   make[3]: Target '__build' not remade because of errors.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 31013 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160825/22fa44e0/attachment-0001.obj>
