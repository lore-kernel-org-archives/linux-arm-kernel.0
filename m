From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 01 Jul 2012 01:57:56 +0400
Subject: [PATCH v2 3/4] usb: chipidea: ci13xxx-imx: add "dr_mode" property
 to device tree bindings
In-Reply-To: <1340891629-13145-4-git-send-email-mkl@pengutronix.de>
References: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
 <1340891629-13145-4-git-send-email-mkl@pengutronix.de>
Message-ID: <4FEF7664.3070707@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 28-06-2012 17:53, Marc Kleine-Budde wrote:

> This patch allows the device tree to limit the chipidea to host or
> peripheral mode only.

> Signed-off-by: Marc Kleine-Budde<mkl@pengutronix.de>
[...]

> diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> index 5a0ad66..67f97f56 100644
> --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> @@ -4,6 +4,8 @@ Required properties:
>   - compatible: Should be "fsl,imx27-usb"
>   - reg: Should contain registers location and length
>   - interrupts: Should contain controller interrupt
> +- dr_mode: indicates the working mode for compatible controllers. Can

     Hyphens are preferred to underscores in the device tree property names.

> +  be "host", "peripheral", or "otg". Defaults to "otg" if not defined.

>   Optional properties:
>   - fsl,usbphy: phandler of usb phy that connects to the only one port

WBR, Sergei
