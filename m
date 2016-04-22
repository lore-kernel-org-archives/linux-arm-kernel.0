From: lkp@intel.com (kbuild test robot)
Date: Fri, 22 Apr 2016 17:38:05 +0800
Subject: [PATCH v7 4/8] dt-bindings: Add a binding for Mediatek Video
 Encoder
In-Reply-To: <1461299131-57851-5-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <201604221712.5n3iXFJo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.6-rc4 next-20160421]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Tiffany-Lin/Add-MT8173-Video-Encoder-Driver-and-VPU-Driver/20160422-123111
base:   git://linuxtv.org/media_tree.git master
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "max_pfn" [drivers/media/platform/mtk-vpu/mtk-vpu.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54453 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160422/e74910fe/attachment-0001.obj>
