From: lkp@intel.com (kbuild test robot)
Date: Wed, 30 Sep 2015 21:46:05 +0800
Subject: [PATCH 8/8] nvmem: Adding bindings for rockchip-efuse
In-Reply-To: <1443617804-26656-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <201509302107.qXqgxYhn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ZhengShunQian,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

reproduce:
  # apt-get install sparse
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/nvmem/rockchip-efuse.c:104:22: sparse: symbol 'rockchip_efuse_regmap_config' was not declared. Should it be static?
>> drivers/nvmem/rockchip-efuse.c:122:5: sparse: symbol 'rockchip_efuse_probe' was not declared. Should it be static?
>> drivers/nvmem/rockchip-efuse.c:168:5: sparse: symbol 'rockchip_efuse_remove' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
