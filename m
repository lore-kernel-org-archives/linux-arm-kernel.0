From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 17 Jun 2015 16:36:01 +0200
Subject: [PATCH] clk: at91: trivial: typo in peripheral clock description
In-Reply-To: <1434547371-12123-1-git-send-email-nicolas.ferre@atmel.com>
References: <1434547371-12123-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150617163601.213e9e67@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Jun 2015 15:22:51 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  Documentation/devicetree/bindings/clock/at91-clock.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
> index 7a4d4926f44e..5ba6450693b9 100644
> --- a/Documentation/devicetree/bindings/clock/at91-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
> @@ -248,7 +248,7 @@ Required properties for peripheral clocks:
>  - #address-cells : shall be 1 (reg is used to encode clk id).
>  - clocks : shall be the master clock phandle.
>  	e.g. clocks = <&mck>;
> -- name: device tree node describing a specific system clock.
> +- name: device tree node describing a specific peripheral clock.
>  	* #clock-cells : from common clock binding; shall be set to 0.
>  	* reg: peripheral id. See Atmel's datasheets to get a full
>  	  list of peripheral ids.



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
