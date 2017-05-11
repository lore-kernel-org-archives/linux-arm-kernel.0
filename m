From: lkp@intel.com (kbuild test robot)
Date: Thu, 11 May 2017 20:04:35 +0800
Subject: [PATCH] drm: mediatek: change the variable type of rdma threshold
In-Reply-To: <1494387348-41170-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <201705111900.oYtnAV4s%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bibby,

[auto build test ERROR on v4.9-rc8]
[cannot apply to drm/drm-next next-20170510]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bibby-Hsieh/drm-mediatek-change-the-variable-type-of-rdma-threshold/20170510-114823
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "__aeabi_uldivmod" [drivers/gpu/drm/mediatek/mediatek-drm.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59469 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170511/13772b99/attachment-0001.gz>
