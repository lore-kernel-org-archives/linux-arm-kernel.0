From: lkp@intel.com (kbuild test robot)
Date: Sat, 2 Jun 2018 21:53:11 +0800
Subject: [clk:clk-qcom-sdm845 12/13] ERROR: "clk_fabia_pll_configure"
 [drivers/clk/qcom/videocc-sdm845.ko] undefined!
Message-ID: <201806022109.6nqKxaxV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-qcom-sdm845
head:   a3dcdc7e5417a369f59214f67cd642c95017cf3b
commit: c646b347669587790db6c703d0786bb5a2639bdd [12/13] clk: qcom: Add video clock controller driver for SDM845
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout c646b347669587790db6c703d0786bb5a2639bdd
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the clk/clk-qcom-sdm845 HEAD a3dcdc7e5417a369f59214f67cd642c95017cf3b builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> ERROR: "clk_fabia_pll_configure" [drivers/clk/qcom/videocc-sdm845.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62909 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180602/93f1a1e9/attachment-0001.gz>
