From: lkp@intel.com (kbuild test robot)
Date: Wed, 22 Nov 2017 15:41:25 +0800
Subject: [PATCH] media: mtk-vcodec: add missing MODULE_LICENSE/DESCRIPTION
In-Reply-To: <20171120062607.124734-1-jc@linux.com>
References: <20171120062607.124734-1-jc@linux.com>
Message-ID: <201711221521.lmq1l8ci%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jesse,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.14 next-20171121]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jesse-Chan/media-mtk-vcodec-add-missing-MODULE_LICENSE-DESCRIPTION/20171122-124620
base:   git://linuxtv.org/media_tree.git master
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

>> drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c:55:16: error: expected declaration specifiers or '...' before string constant
    MODULE_LICENSE("GPL v2");
                   ^
   drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c:56:20: error: expected declaration specifiers or '...' before string constant
    MODULE_DESCRIPTION("Mediatek video codec driver");
                       ^

vim +55 drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c

    54	
  > 55	MODULE_LICENSE("GPL v2");

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51526 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171122/78bae7d9/attachment-0001.gz>
