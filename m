From: lkp@intel.com (kbuild test robot)
Date: Sun, 11 Feb 2018 15:54:13 +0800
Subject: [PATCH v8 2/3] mtd: spi-nor: add rockchip serial flash
 controller driver
In-Reply-To: <1518092327-3827-1-git-send-email-andy.yan@rock-chips.com>
References: <1518092327-3827-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <201802111502.mUO8hPlO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.15 next-20180209]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andy-Yan/Add-Rockchip-SFC-serial-flash-controller-support/20180211-135616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/mtd/spi-nor/rockchip-sfc.c:899:5: sparse: symbol 'rockchip_sfc_runtime_suspend' was not declared. Should it be
>> drivers/mtd/spi-nor/rockchip-sfc.c:907:5: sparse: symbol 'rockchip_sfc_runtime_resume' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
