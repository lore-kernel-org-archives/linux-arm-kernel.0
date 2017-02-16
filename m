From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 16 Feb 2017 12:54:11 +0100
Subject: [PATCH v4 01/36] [media] dt-bindings: Add bindings for i.MX
 media driver
In-Reply-To: <1487211578-11360-2-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-2-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1487246051.2377.41.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-02-15 at 18:19 -0800, Steve Longerbeam wrote:
> Add bindings documentation for the i.MX media driver.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> ---
>  Documentation/devicetree/bindings/media/imx.txt | 66 +++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/imx.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/imx.txt b/Documentation/devicetree/bindings/media/imx.txt
> new file mode 100644
> index 0000000..fd5af50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/imx.txt
> @@ -0,0 +1,66 @@
> +Freescale i.MX Media Video Device
> +=================================
> +
> +Video Media Controller node
> +---------------------------
> +
> +This is the media controller node for video capture support. It is a
> +virtual device that lists the camera serial interface nodes that the
> +media device will control.
> +
> +Required properties:
> +- compatible : "fsl,imx-capture-subsystem";
> +- ports      : Should contain a list of phandles pointing to camera
> +		sensor interface ports of IPU devices
> +
> +example:
> +
> +capture-subsystem {
> +	compatible = "fsl,capture-subsystem";

"fsl,imx-capture-subsystem"

regards
Philipp
