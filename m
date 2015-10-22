From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 22 Oct 2015 13:41:38 -0500
Subject: [PATCH 10/11] Documentation: Rename gpio controller name from
 cygnus to iproc
In-Reply-To: <1445233398-27129-11-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <1445233398-27129-11-git-send-email-pramodku@broadcom.com>
Message-ID: <CAL_JsqLvAtqR1Vwv0_3OBq4EvYA2VKX5Zrf5YsouKWADypy5eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 12:43 AM, Pramod Kumar <pramodku@broadcom.com> wrote:
> Renamed gpio controller's driver name from cygnus to iproc to make it
> more generic so that all iProc based SoCs having the same gpio controller
> could use this.
>
> Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../bindings/pinctrl/{brcm,cygnus-gpio.txt => brcm,iproc-gpio.txt}    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/pinctrl/{brcm,cygnus-gpio.txt => brcm,iproc-gpio.txt} (97%)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,iproc-gpio.txt
> similarity index 97%
> rename from Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
> rename to Documentation/devicetree/bindings/pinctrl/brcm,iproc-gpio.txt
> index 655a8d7..7fb4621 100644
> --- a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/brcm,iproc-gpio.txt
> @@ -1,4 +1,4 @@
> -Broadcom Cygnus GPIO/PINCONF Controller
> +Broadcom iProc GPIO/PINCONF Controller
>
>  Required properties:
>
> @@ -7,7 +7,7 @@ Required properties:
>  "brcm,cygnus-crmu-gpio" or "brcm,iproc-gpio"
>
>  - reg:
> -    Define the base and range of the I/O address space that contains the Cygnus
> +    Define the base and range of the I/O address space that contains SoC
>  GPIO/PINCONF controller registers
>
>  - ngpios:
> --
> 1.9.1
>
