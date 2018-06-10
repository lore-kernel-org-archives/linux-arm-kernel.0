From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 10 Jun 2018 13:31:31 +0100
Subject: [PATCH v7 3/9] dt-bindings: input: touchscreen: add minimum
 pressure touchscreen property
In-Reply-To: <1526975559-18966-4-git-send-email-eugen.hristev@microchip.com>
References: <1526975559-18966-1-git-send-email-eugen.hristev@microchip.com>
 <1526975559-18966-4-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20180610133131.2ec1ddae@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 May 2018 10:52:33 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Add a common touchscreen optional property that will specify
> the minimum pressure applied to the screen that is needed
> such that the driver will report the touch event.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied, Thanks,

Jonathan
> ---
> Changes in v5:
>  - Modified property name to touchscreen-min-pressure from
> touchscreen-threshold-property
> 
>  Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> index 537643e..d092d5d 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> @@ -7,6 +7,9 @@ Optional properties for Touchscreens:
>  				  (in pixels)
>   - touchscreen-max-pressure	: maximum reported pressure (arbitrary range
>  				  dependent on the controller)
> + - touchscreen-min-pressure	: minimum pressure on the touchscreen to be
> +				  achieved in order for the touchscreen
> +				  driver to report a touch event.
>   - touchscreen-fuzz-x		: horizontal noise value of the absolute input
>  				  device (in pixels)
>   - touchscreen-fuzz-y		: vertical noise value of the absolute input
