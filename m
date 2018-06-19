From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 19 Jun 2018 11:23:07 -0700
Subject: [PATCH] dt-bindings: Fix unbalanced quotation marks
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Message-ID: <20180619182307.GG71788@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2018 at 04:31:18PM +0200, Jonathan Neusch?fer wrote:
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> index 121d9b7c79a2..1063c30d53f7 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> @@ -32,7 +32,7 @@ i2c at 00000000 {
>  		reg = <0x6c>;
>  		interrupt-parent = <&gpx1>;
>  		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> -		vdd-supply = <&ldo15_reg>";
> +		vdd-supply = <&ldo15_reg>;
>  		vid-supply = <&ldo18_reg>;
>  		reset-gpios = <&gpx1 5 0>;
>  		touchscreen-size-x = <1080>;

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
