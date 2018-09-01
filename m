From: lkp@intel.com (kbuild test robot)
Date: Sun, 2 Sep 2018 05:23:40 +0800
Subject: [RESEND PATCH v11 5/6] spi: at91-usart: add driver for
 at91-usart as spi
In-Reply-To: <20180831134141.9335-6-radu.pirea@microchip.com>
References: <20180831134141.9335-6-radu.pirea@microchip.com>
Message-ID: <201809020500.AUGWBTuR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Radu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ljones-mfd/for-mfd-next]
[also build test WARNING on v4.19-rc1 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Radu-Pirea/Driver-for-at91-usart-in-spi-mode/20180901-165150
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/spi/spi-at91-usart.c:218:5: sparse: symbol 'at91_usart_spi_transfer_one' was not declared. Should it be static?
>> drivers/spi/spi-at91-usart.c:245:5: sparse: symbol 'at91_usart_spi_prepare_message' was not declared. Should it be static?
>> drivers/spi/spi-at91-usart.c:259:5: sparse: symbol 'at91_usart_spi_unprepare_message' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
