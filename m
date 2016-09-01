From: lkp@intel.com (kbuild test robot)
Date: Fri, 2 Sep 2016 05:49:32 +0800
Subject: [PATCH 3/5] clocks: exynos4x12: add runtime pm support for ISP
 clocks
In-Reply-To: <1472737551-15272-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201609020505.HiC8887e%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

[auto build test WARNING on clk/clk-next]
[also build test WARNING on next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Marek-Szyprowski/Add-runtime-PM-support-for-clocks-on-Exynos-SoC-example/20160901-215042
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.data+0x135420): Section mismatch in reference from the variable exynos4x12_isp_clk_driver to the function .init.text:exynos4x12_isp_clk_probe()
   The variable exynos4x12_isp_clk_driver references
   the function __init exynos4x12_isp_clk_probe()
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 58542 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160902/fb16b17c/attachment-0001.obj>
