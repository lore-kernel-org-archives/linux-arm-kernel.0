From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 14 Feb 2018 12:31:48 +0800
Subject: [nomadik:gemini-dir-685-rtl8366rb 2/7] ERROR: "of_irq_count"
 [net/dsa/dsa_core.ko] undefined!
Message-ID: <201802141246.IImDOB6W%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-dir-685-rtl8366rb
head:   7089cc0dd27d82e2ed9adaded66ffd8973017dd0
commit: 8f6b1418ccd0f05ca0556a5bec68d05a4b638d7d [2/7] RFC: net/dsa: Allow DSA PHYs to define link IRQs
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 8f6b1418ccd0f05ca0556a5bec68d05a4b638d7d
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "of_irq_count" [net/dsa/dsa_core.ko] undefined!
   make[2]: *** [__modpost] Error 1
   make[2]: Target '_modpost' not remade because of errors.
   make[1]: *** [modules] Error 2
   make[1]: Target '_all' not remade because of errors.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63077 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180214/35875292/attachment-0001.gz>
