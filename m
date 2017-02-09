From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 10 Feb 2017 02:29:08 +0800
Subject: [stericsson:mmc-no-NULL 33/34] ERROR: "mmc_blk_rw_done_success"
 [drivers/mmc/core/mmc_core.ko] undefined!
Message-ID: <201702100205.lV06nr1C%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-no-NULL
head:   1bec9a625b256f78d00c38b58caad7ccdae8aaf5
commit: a2058ff91a2df34d5e26cca917b8fee35f051151 [33/34] mmc: queue: issue requests in massive parallel
config: x86_64-rhel-7.2 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout a2058ff91a2df34d5e26cca917b8fee35f051151
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   ERROR: "mmc_queue_req_put" [drivers/mmc/core/mmc_core.ko] undefined!
>> ERROR: "mmc_blk_rw_done_success" [drivers/mmc/core/mmc_core.ko] undefined!
>> ERROR: "mmc_blk_rw_done_error" [drivers/mmc/core/mmc_core.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38277 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/3a8565a6/attachment-0001.gz>
