From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Mon, 22 Nov 2010 18:08:31 +0200
Subject: rm9200: update
In-Reply-To: <20101120095906.GD4216@game.jcrosoft.org>
References: <20101120095906.GD4216@game.jcrosoft.org>
Message-ID: <AANLkTim_tA2KHmvmXeaK6oU1Yj-Eak62SBqn4BGo+Dyq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Jean-Christophe,

> ? ? ? ?this patch update some issues found on rm9200
> ? ? ? ?during the test of the rm9200 defconfig consolidation
>
>
> ?git://git.jcrosoft.org/linux-2.6.git rm9200
>
> Jean-Christophe PLAGNIOL-VILLARD (6):
> ? ? ?at91: Convert remaining boards to new-style UART initialization
> ? ? ?at91rm9200dk: fix warning: 'dk_mmc_data' defined but not used
> ? ? ?at91rm9200ek: fix warning: 'ek_mmc_data' defined but not used
> ? ? ?at91/picotux200: fix warning: 'picotux200_mmc_data' defined but not used
> ? ? ?at91: rename rm9200ek and rm9200dk board file name

For patches 1, 2, 3, 4 and 5 you can add a:
  Signed-off-by: Andrew Victor <linux@maxim.org.za>


> ? ? ?atmel_spi: fix warning In function 'atmel_spi_dma_map_xfer'


Regards,
  Andrew Victor
