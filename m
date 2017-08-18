From: lkp@intel.com (kbuild test robot)
Date: Fri, 18 Aug 2017 10:30:05 +0800
Subject: [PATCH v4 3/3] drm/rockchip: Add support for Rockchip Soc LVDS
In-Reply-To: <1502758574-113964-1-git-send-email-hjc@rock-chips.com>
Message-ID: <201708181006.Ty2kKG13%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sandy,

[auto build test ERROR on robh/for-next]
[cannot apply to rockchip/for-next v4.13-rc5 next-20170817]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sandy-Huang/Add-support-Rockchip-Soc-LVDS/20170818-024639
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "drm_bridge_detach" [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63417 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170818/6e8093a9/attachment-0001.gz>
