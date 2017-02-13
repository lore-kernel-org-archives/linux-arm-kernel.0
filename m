From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 14 Feb 2017 01:30:38 +0800
Subject: [stericsson:mmc-no-NULL 29/34] ERROR: "mmc_blk_rw_done"
 [drivers/mmc/core/mmc_core.ko] undefined!
Message-ID: <201702140133.hITWgcna%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-no-NULL
head:   c8140f7069d2f17882ea16e78265b7e31c4b5e45
commit: 4515dc6f7347baa369f13e489bfa5d431e03dbe0 [29/34] mmc: block: shuffle retry and error handling
config: x86_64-rhel (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 4515dc6f7347baa369f13e489bfa5d431e03dbe0
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the stericsson/mmc-no-NULL HEAD c8140f7069d2f17882ea16e78265b7e31c4b5e45 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> ERROR: "mmc_blk_rw_done" [drivers/mmc/core/mmc_core.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38277 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170214/12211dd8/attachment-0001.gz>
