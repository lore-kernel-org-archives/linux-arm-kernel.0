From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 1 Feb 2016 19:21:53 +0800
Subject: [PATCH 1/2] of: add vendor prefix for UniWest
In-Reply-To: <b11bf2208fe30b96c4d82e634e8abe04343754de.1452717014.git.stillcompiling@gmail.com>
References: <b11bf2208fe30b96c4d82e634e8abe04343754de.1452717014.git.stillcompiling@gmail.com>
Message-ID: <20160201112153.GD10671@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 12:45:11PM -0800, Joshua Clayton wrote:
> United Western Technologies Corp, known primarily as UniWest,
> is a manufacturer of eddy current and ultrasonic testing equipment.
> 
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 55df1d4..7dabdee 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -230,6 +230,7 @@ toradex	Toradex AG
>  toshiba	Toshiba Corporation
>  toumaz	Toumaz
>  tplink	TP-LINK Technologies Co., Ltd.
> +uniwest	United Western Technologies Corp (UniWest)

As far as I know, it should be added in alphabetical order.

Shawn

>  tronfy	Tronfy
>  truly	Truly Semiconductors Limited
>  upisemi	uPI Semiconductor Corp.
> -- 
> 2.5.0
> 
> 
