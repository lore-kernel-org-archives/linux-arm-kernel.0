From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 20:00:18 -0500
Subject: [PATCH v4 2/6] dt-bindings: add binding for atmel-usart in SPI
 mode
In-Reply-To: <20180525171941.26766-3-radu.pirea@microchip.com>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-3-radu.pirea@microchip.com>
Message-ID: <20180531010018.GA24002@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 08:19:37PM +0300, Radu Pirea wrote:
> This patch moves the bindings for serial from serial/atmel-usart.txt to
> mfd/atmel-usart.txt and adds bindings for USART in SPI mode.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  .../bindings/{serial => mfd}/atmel-usart.txt  | 25 +++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)

Reviewed-by: Rob Herring <robh@kernel.org>
