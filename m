From: dmurphy@ti.com (Murphy, Dan)
Date: Thu, 4 Sep 2014 13:21:48 +0000
Subject: [PATCH v2 1/2] doc: dt/bindings: input: introduce TI DRV2667
 haptic driver description
References: <1408980413-8763-1-git-send-email-dmurphy@ti.com>
Message-ID: <00FC9A978A94B7418C33AFAE8A35ED49E385C5@DFLE09.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bumping x2

On 08/25/2014 10:26 AM, Murphy, Dan wrote:
> DRV2667 is a haptic/vibrator driver for Linear Resonant Actuators.
> Adding dt binding for this part
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v2 - Removed extra tabs, changed node to function not device
> added vbat-supply, and removed confusing description - https://patchwork.kernel.org/patch/4759381/
> 
>  .../devicetree/bindings/input/ti,drv2667.txt       |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/ti,drv2667.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/ti,drv2667.txt b/Documentation/devicetree/bindings/input/ti,drv2667.txt
> new file mode 100644
> index 0000000..996382c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ti,drv2667.txt
> @@ -0,0 +1,17 @@
> +* Texas Instruments - drv2667 Haptics driver
> +
> +Required properties:
> +	- compatible - "ti,drv2667" - DRV2667
> +	- reg -  I2C slave address
> +	- vbat-supply - Required supply regulator
> +
> +Example:
> +
> +haptics: haptics at 59 {
> +	compatible = "ti,drv2667";
> +	reg = <0x59>;
> +	vbat-supply = <&vbat>;
> +};
> +
> +For more product information please see the link below:
> +http://www.ti.com/product/drv2667
> 


-- 
------------------
Dan Murphy
