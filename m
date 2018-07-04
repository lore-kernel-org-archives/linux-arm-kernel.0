From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Jul 2018 07:23:16 +0100
Subject: [PATCH v10 2/6] dt-bindings: add binding for atmel-usart in SPI
 mode
In-Reply-To: <20180625172230.29686-3-radu.pirea@microchip.com>
References: <20180625172230.29686-1-radu.pirea@microchip.com>
 <20180625172230.29686-3-radu.pirea@microchip.com>
Message-ID: <20180704062316.GY20176@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Jun 2018, Radu Pirea wrote:

> This patch moves the bindings for serial from serial/atmel-usart.txt to
> mfd/atmel-usart.txt and adds bindings for USART in SPI mode.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I already Acked this in V4.

> ---
>  .../bindings/{serial => mfd}/atmel-usart.txt  | 25 +++++++++++++++++--
>  include/dt-bindings/mfd/at91-usart.h          | 17 +++++++++++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
>  create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
