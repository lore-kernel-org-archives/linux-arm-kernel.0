From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 30 May 2016 01:07:59 -0700
Subject: [PATCH v3 1/2] doc/devicetree: Add Aspeed watchdog timer bindings
In-Reply-To: <1463559661-14170-2-git-send-email-joel@jms.id.au>
References: <1463062631-16432-1-git-send-email-joel@jms.id.au>
 <1463559661-14170-1-git-send-email-joel@jms.id.au>
 <1463559661-14170-2-git-send-email-joel@jms.id.au>
Message-ID: <574BF4DF.6000305@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2016 01:20 AM, Joel Stanley wrote:
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../devicetree/bindings/watchdog/aspeed-wdt.txt          | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> new file mode 100644
> index 000000000000..c5e74d7b4406
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> @@ -0,0 +1,16 @@
> +Aspeed Watchdog Timer
> +
> +Required properties:
> + - compatible: must be one of:
> +	- "aspeed,ast2400-wdt"
> +	- "aspeed,ast2500-wdt"
> +
> + - reg: physical base address of the controller and length of memory mapped
> +   region
> +
> +Example:
> +
> +	wdt1: watchdog at 1e785000 {
> +		compatible = "aspeed,ast2400-wdt";
> +		reg = <0x1e785000 0x1c>;
> +	};
>
