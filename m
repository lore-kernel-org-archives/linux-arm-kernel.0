From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 28 Feb 2014 15:36:51 +0100
Subject: [PATCH] Doc: USB: gadget: atmel_usba correct atmel,vbus-gpio
 meaning
In-Reply-To: <1393515910-15837-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1393515910-15837-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <53109F03.6060506@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/2014 16:45, Alexandre Belloni :
> atmel,at91sam9rl-udc is a USB gadget, it has now means to control vbus.

s/now/no/

> atmel,vbus-gpio is in fact used to detect the presence of vbus.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  Documentation/devicetree/bindings/usb/atmel-usb.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> index 55f51af08bc7..bc2222ca3f2a 100644
> --- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> @@ -57,8 +57,8 @@ Required properties:
>   - ep childnode: To specify the number of endpoints and their properties.
>  
>  Optional properties:
> - - atmel,vbus-gpio: If present, specifies a gpio that needs to be
> -   activated for the bus to be powered.
> + - atmel,vbus-gpio: If present, specifies a gpio that allows to detect whether
> +   vbus is present (USB is connected).
>  
>  Required child node properties:
>   - name: Name of the endpoint.
> 


-- 
Nicolas Ferre
