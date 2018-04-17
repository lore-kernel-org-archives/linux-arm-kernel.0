From: lkp@intel.com (kbuild test robot)
Date: Wed, 18 Apr 2018 03:53:23 +0800
Subject: [spi:for-4.18 12/12] drivers/spi/spi-pxa2xx.c:914:5: sparse: symbol
 'pxa2xx_spi_transfer_one' was not declared. Should it be static?
Message-ID: <201804180300.Pn9JAJQ2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-4.18
head:   d5898e19c0d74cd41b9f5c8c8ea87e559c3fe0c1
commit: d5898e19c0d74cd41b9f5c8c8ea87e559c3fe0c1 [12/12] spi: pxa2xx: Use core message processing loop
reproduce:
        # apt-get install sparse
        git checkout d5898e19c0d74cd41b9f5c8c8ea87e559c3fe0c1
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/spi/spi-pxa2xx.c:877:16: sparse: expression using sizeof(void)
   drivers/spi/spi-pxa2xx.c:877:16: sparse: expression using sizeof(void)
>> drivers/spi/spi-pxa2xx.c:914:5: sparse: symbol 'pxa2xx_spi_transfer_one' was not declared. Should it be static?
   drivers/spi/spi-pxa2xx.c:1672:42: sparse: expression using sizeof(void)
   drivers/spi/spi-pxa2xx.c:1672:42: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
