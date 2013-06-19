From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Jun 2013 10:22:51 +0200
Subject: [PATCH V3 5/5] input: pxa27x-keypad: add device tree support
In-Reply-To: <1371527778-5236-6-git-send-email-chao.xie@marvell.com>
References: <1371527778-5236-1-git-send-email-chao.xie@marvell.com>
 <1371527778-5236-6-git-send-email-chao.xie@marvell.com>
Message-ID: <201306191022.51630.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chao Xie,

> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
>  .../devicetree/bindings/input/pxa27x-keypad.txt    |   60 +++++
>  drivers/input/keyboard/pxa27x_keypad.c             |  232
> +++++++++++++++++++- 2 files changed, 288 insertions(+), 4 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/input/pxa27x-keypad.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/pxa27x-keypad.txt
> b/Documentation/devicetree/bindings/input/pxa27x-keypad.txt new file mode
> 100644
> index 0000000..f8674f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/pxa27x-keypad.txt
> @@ -0,0 +1,60 @@
> +* Marvell PXA Keypad controller
> +
> +Required Properties
> +- compatible : should be "marvell,pxa27x-keypad"
> +- reg : Address and length of the register set for the device
> +- interrupts : The interrupt for the keypad controller
> +- marvell,debounce-interval : How long time the key will be

Is there no generic prop name for this debounce interval?

Best regards,
Marek Vasut
