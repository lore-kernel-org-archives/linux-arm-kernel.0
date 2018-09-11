From: pirea.radu@gmail.com (Radu Nicolae Pirea)
Date: Tue, 11 Sep 2018 11:14:33 +0300
Subject: [GIT PULL] Immutable branch between MFD, SPI and TTY due for
 the v4.20 merge window
In-Reply-To: <20180910151803.GX28860@dell>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell>
Message-ID: <bd9104b702feec556ed01311e9efcb96790131d0.camel@upb.ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Thank you for taking the patch series, but you didn't take the latest
version(v12) :)


On Mon, 2018-09-10 at 16:18 +0100, Lee Jones wrote:
> Enjoy!
> 
> The following changes since commit
> 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-
> mfd-spi-tty-v4.20
> 
> for you to fetch changes up to
> c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:
> 
>   tty/serial: atmel: Change the driver to work under at91-usart MFD
> (2018-09-10 16:12:43 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD, SPI and TTY due for the v4.20 merge
> window
> 
> ----------------------------------------------------------------
> Radu Pirea (6):
>       MAINTAINERS: Add AT91 USART MFD entry
>       dt-bindings: Add binding for atmel-usart in SPI mode
>       mfd: at91-usart: Add MFD driver for USART
>       MAINTAINERS: Add AT91 USART SPI entry
>       spi: at91-usart: Add driver for at91-usart as SPI
>       tty/serial: atmel: Change the driver to work under at91-usart
> MFD
> 
>  .../bindings/{serial => mfd}/atmel-usart.txt       |  25 +-
>  MAINTAINERS                                        |  16 +
>  drivers/mfd/Kconfig                                |   9 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/at91-usart.c                           |  71 ++++
>  drivers/spi/Kconfig                                |   8 +
>  drivers/spi/Makefile                               |   1 +
>  drivers/spi/spi-at91-usart.c                       | 432
> +++++++++++++++++++++
>  drivers/tty/serial/Kconfig                         |   1 +
>  drivers/tty/serial/atmel_serial.c                  |  42 +-
>  include/dt-bindings/mfd/at91-usart.h               |  17 +
>  11 files changed, 606 insertions(+), 17 deletions(-)
>  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-
> usart.txt (76%)
>  create mode 100644 drivers/mfd/at91-usart.c
>  create mode 100644 drivers/spi/spi-at91-usart.c
>  create mode 100644 include/dt-bindings/mfd/at91-usart.h
> 
