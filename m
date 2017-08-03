From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 14:05:48 -0500
Subject: [PATCH v2 2/6] dt-bindings: usb: Add documentation for NS2 CDRU
 USB3
In-Reply-To: <1501109787-15489-3-git-send-email-jon.mason@broadcom.com>
References: <1501109787-15489-1-git-send-email-jon.mason@broadcom.com>
 <1501109787-15489-3-git-send-email-jon.mason@broadcom.com>
Message-ID: <20170803190548.k4mccsmpzaql45p3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 06:56:23PM -0400, Jon Mason wrote:
> Add documentation for CDRU USB3 registers available in NS2 SoC
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---
>  .../devicetree/bindings/usb/brcm,cdru-usb3-ctrl.txt        | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,cdru-usb3-ctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/brcm,cdru-usb3-ctrl.txt b/Documentation/devicetree/bindings/usb/brcm,cdru-usb3-ctrl.txt
> new file mode 100644
> index 000000000000..30c03bef58fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/brcm,cdru-usb3-ctrl.txt
> @@ -0,0 +1,14 @@
> +Broadcom Chip Device Resource Unit USB3 register
> +
> +Required properties:
> +- compatible: "brcm,cdru-usb3-ctrl"
> +- reg: Base address and length of the USB registers
> +
> +
> +Example:
> +
> +cdru_usb3_ctrl: cdru_usb3_ctrl at 6501d144 {

s/_/-/

With that,

Acked-by: Rob Herring <robh@kernel.org>

> +        compatible = "brcm,cdru-usb3-ctrl";
> +        reg = <0x6501d144 0x4>;
> +};
> +
> -- 
> 2.7.4
> 
