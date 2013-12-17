From: pekon@ti.com (Gupta, Pekon)
Date: Tue, 17 Dec 2013 04:08:33 +0000
Subject: [PATCH v3 0/7] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <1387184330-14448-1-git-send-email-b32955@freescale.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA56ADC@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shijie,

>From: Huang Shijie [mailto:b32955 at freescale.com]
[...]
>Huang Shijie (7):
>  mtd: spi-nor: copy the SPI NOR commands to a new header file
>  mtd: spi-nor: add the basic data structures
>  mtd: spi-nor: add the framework for SPI NOR
>  mtd: m25p80: use the SPI nor framework
>  mtd: spi-nor: add a helper to find the spi_device_id
>  Documentation: add the binding file for Quadspi driver
>  mtd: spi-nor: Add Freescale QuadSpi driver
>
> .../devicetree/bindings/mtd/fsl-quadspi.txt        |   31 +
> drivers/mtd/Kconfig                                |    2 +
> drivers/mtd/Makefile                               |    1 +
> drivers/mtd/devices/Kconfig                        |    2 +-
> drivers/mtd/devices/m25p80.c                       | 1271 ++------------------

As much base code is copied from m25p90.c,
Do you mind keeping the sign-offs of the original contributors of m25p80.c
at-least in patches where much code is ported ?
This would at-least give some credit to original authors and contributors.

with regards, pekon
