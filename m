From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 10 Jan 2018 23:23:05 +0800
Subject: [asoc:topic/iio 9/11] drivers/iio/adc/stm32-dfsdm-adc.c:241:6:
 sparse: symbol 'stm32_dfsdm_stop_filter' was not declared. Should it be
 static?
Message-ID: <201801102320.fKoiIrHz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/iio
head:   16cbca06fa8288a4f58426fc898b141e12ee8008
commit: e2e6771c646251657fafb2a78db566d5c2c70635 [9/11] IIO: ADC: add STM32 DFSDM sigma delta ADC support
reproduce:
        # apt-get install sparse
        git checkout e2e6771c646251657fafb2a78db566d5c2c70635
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/iio/adc/stm32-dfsdm-adc.c:241:6: sparse: symbol 'stm32_dfsdm_stop_filter' was not declared. Should it be
>> drivers/iio/adc/stm32-dfsdm-adc.c:283:5: sparse: symbol 'stm32_dfsdm_channel_parse_of' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
