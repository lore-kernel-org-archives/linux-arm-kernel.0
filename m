From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Dec 2015 21:45:24 -0600
Subject: [PATCH 3/3] ARM: dts: sunxi: allwinner,sun4i-a10-lradc-keys
 binding: typo fix
In-Reply-To: <1449779521-754-4-git-send-email-merker@debian.org>
References: <1449779521-754-1-git-send-email-merker@debian.org>
 <1449779521-754-4-git-send-email-merker@debian.org>
Message-ID: <20151211034524.GA6166@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 09:32:01PM +0100, Karsten Merker wrote:
> Trivial typo fix ("mut" -> "must") in the sunxi LRADC-keys binding
> documentation.
> 
> Signed-off-by: Karsten Merker <merker@debian.org>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> index b9c32f6..4357e49 100644
> --- a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> +++ b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> @@ -12,7 +12,7 @@ Each key is represented as a sub-node of "allwinner,sun4i-a10-lradc-keys":
>  Required subnode-properties:
>  	- label: Descriptive name of the key.
>  	- linux,code: Keycode to emit.
> -	- channel: Channel this key is attached to, mut be 0 or 1.
> +	- channel: Channel this key is attached to, must be 0 or 1.
>  	- voltage: Voltage in ?V at lradc input when this key is pressed.
>  
>  Example:
> -- 
> 2.1.4
> 
