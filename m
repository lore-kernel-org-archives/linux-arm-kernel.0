From: lee@kernel.org (Lee Jones)
Date: Tue, 28 Apr 2015 10:34:16 +0100
Subject: [PATCH 1/3] dt/bindings: Add binding for the Raspberry Pi
 firmware driver
In-Reply-To: <1430176449-12322-2-git-send-email-eric@anholt.net>
References: <1430176449-12322-1-git-send-email-eric@anholt.net>
 <1430176449-12322-2-git-send-email-eric@anholt.net>
Message-ID: <20150428093416.GK11956@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Apr 2015, Eric Anholt wrote:

> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../devicetree/bindings/arm/bcm/raspberrypi,firmware.txt   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,firmware.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,firmware.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,firmware.txt
> new file mode 100644
> index 0000000..a74c966
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,firmware.txt
> @@ -0,0 +1,14 @@
> +Raspberry Pi VideoCore firmware driver
> +
> +Required properties:
> +
> +- compatible:	Should be "rasbperrypi,firmware"
> +- mboxes:	Single-entry list which specifies which mailbox controller
> +		  and channel is used.

#power-domain-cells?

> +Example:
> +
> +firmware {
> +	compatible = "rasbperrypi,firmware";
> +	mboxes = <&mailbox 0>
> +};
