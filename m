From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Feb 2018 17:12:25 +0800
Subject: [PATCH v4 06/13] power: supply: axp20x_battery: use data struct
 for variant specific code
In-Reply-To: <52f68b8ed9452d643d9156a849014c9d0eb4404b.1519044068.git-series.quentin.schulz@bootlin.com>
References: <52f68b8ed9452d643d9156a849014c9d0eb4404b.1519044068.git-series.quentin.schulz@bootlin.com>
Message-ID: <201802201606.lLg38XZv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Quentin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ]

url:    https://github.com/0day-ci/linux/commits/Quentin-Schulz/add-support-for-AXP813-ADC-and-battery-power-supply/20180220-051138
base:    
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/power/supply/axp20x_battery.c:479:23: sparse: symbol 'axp209_data' was not declared. Should it be
>> drivers/power/supply/axp20x_battery.c:486:23: sparse: symbol 'axp221_data' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
