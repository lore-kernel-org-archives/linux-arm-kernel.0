From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Feb 2017 10:56:38 -0600
Subject: [PATCH 2/4] Documentation: devicetree: arm: Add Realtek RTD1295
 bindings
In-Reply-To: <20170214033440.18667-3-afaerber@suse.de>
References: <20170214033440.18667-1-afaerber@suse.de>
 <20170214033440.18667-3-afaerber@suse.de>
Message-ID: <20170222165638.u5uemzsbldzoytvv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 04:34:37AM +0100, Andreas F?rber wrote:
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Commit message?

Also, preferred subject prefix is "dt-bindings: arm: ".

> ---
>  Documentation/devicetree/bindings/arm/realtek.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/realtek.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Documentation/devicetree/bindings/arm/realtek.txt
> new file mode 100644
> index 0000000..cfbee58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/realtek.txt
> @@ -0,0 +1,15 @@
> +Realtek platforms device tree bindings
> +--------------------------------------
> +
> +
> +RTD1295 SoC
> +===========
> +
> +Required root node properties:
> +
> + - compatible :  "realtek,rtd1295"
> +
> +
> +Board compatible strings:
> +
> + - Zidoo X9S: "zidoo,x9s"
> -- 
> 2.10.2
> 
