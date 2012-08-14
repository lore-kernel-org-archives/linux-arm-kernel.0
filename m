From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 14 Aug 2012 12:51:15 -0700
Subject: [PATCH] Documentation: dt: hwmon: Update for tmp102
In-Reply-To: <1344961412-13622-1-git-send-email-sourav.poddar@ti.com>
References: <1344961412-13622-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <20120814195115.GA17168@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 09:53:32PM +0530, Sourav Poddar wrote:
> Add Documentation for tmp102 temperature sensor.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  Documentation/devicetree/bindings/hwmon/tmp102.txt |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/tmp102.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/tmp102.txt b/Documentation/devicetree/bindings/hwmon/tmp102.txt
> new file mode 100644
> index 0000000..df1342b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/tmp102.txt
> @@ -0,0 +1,11 @@
> +TMP102 Temperature sensor
> +
> +Required properties:
> +- compatible: ti,tmp102
> +
> +Example:
> +
> +tmp102 at 48 {
> +        compatible = "ti,tmp102";
> +        reg = <0x48>;
> +};
> -- 

It would be simpler to just add a single line to
	Documentation/devicetree/bindings/i2c/trivial-devices.txt

Guenter
