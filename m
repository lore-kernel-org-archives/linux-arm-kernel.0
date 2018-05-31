From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 20:02:12 -0500
Subject: [PATCH v4 3/6] mfd: at91-usart: added mfd driver for usart
In-Reply-To: <20180525171941.26766-4-radu.pirea@microchip.com>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-4-radu.pirea@microchip.com>
Message-ID: <20180531010212.GA26508@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 08:19:38PM +0300, Radu Pirea wrote:
> This mfd driver is just a wrapper over atmel_serial driver and
> spi-at91-usart driver. Selection of one of the drivers is based on a
> property from device tree. If the property is not specified, the default
> driver is atmel_serial.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  drivers/mfd/Kconfig                  | 10 ++++
>  drivers/mfd/Makefile                 |  1 +
>  drivers/mfd/at91-usart.c             | 75 ++++++++++++++++++++++++++++

>  include/dt-bindings/mfd/at91-usart.h | 17 +++++++

This really should be part of the binding patch.

Acked-by: Rob Herring <robh@kernel.org>

>  4 files changed, 103 insertions(+)
>  create mode 100644 drivers/mfd/at91-usart.c
>  create mode 100644 include/dt-bindings/mfd/at91-usart.h
