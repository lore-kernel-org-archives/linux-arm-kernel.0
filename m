From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Feb 2018 09:39:00 +0800
Subject: [PATCH 4/8] drm/exynos/dsi: Use clk bulk API
In-Reply-To: <1519055046-2399-5-git-send-email-m.purski@samsung.com>
References: <1519055046-2399-5-git-send-email-m.purski@samsung.com>
Message-ID: <201802200934.LEBzlkD7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maciej,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.16-rc2 next-20180219]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maciej-Purski/Use-clk-bulk-API-in-exynos5433-drivers/20180220-054431
base:   git://linuxtv.org/media_tree.git master
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   ERROR: "devm_clk_bulk_alloc" [drivers/media/platform/s5p-jpeg/s5p-jpeg.ko] undefined!
>> ERROR: "devm_clk_bulk_alloc" [drivers/gpu/drm/exynos/exynosdrm.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 42953 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180220/a46e7cf3/attachment-0001.gz>
