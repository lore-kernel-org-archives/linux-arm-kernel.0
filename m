From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 14 May 2012 13:14:23 +0200 (CEST)
Subject: CSR SiRFSoC PRIMA2: SPI compilation broken in 3.4-rc7
Message-ID: <Pine.LNX.4.64.1205141311060.4916@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Might be good to try to fix for 3.4 release:

drivers/spi/spi-sirf.c: In function 'spi_sirfsoc_probe':
drivers/spi/spi-sirf.c:563: error: implicit declaration of function 'pinmux_get'
drivers/spi/spi-sirf.c:563: warning: assignment makes pointer from integer without a cast
drivers/spi/spi-sirf.c:568: error: implicit declaration of function 'pinmux_enable'
drivers/spi/spi-sirf.c:602: error: implicit declaration of function 'pinmux_disable'
drivers/spi/spi-sirf.c:603: error: implicit declaration of function 'pinmux_put'
make[3]: *** [drivers/spi/spi-sirf.o] Error 1

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
