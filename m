From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Mar 2016 11:41:24 +0100
Subject: [PATCH v4 03/13] clk: sunxi: Add APB1 clock for A83T
In-Reply-To: <1458144276-31108-4-git-send-email-vishnupatekar0510@gmail.com>
References: <1458144276-31108-1-git-send-email-vishnupatekar0510@gmail.com>
 <1458144276-31108-4-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20160317104124.GL30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 12:04:26AM +0800, Vishnu Patekar wrote:
> APB1 is similar to sun4i-a10-apb0-clk, except different dividers.
> 
> This adds support for apb1 on A83T.
> 
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>  drivers/clk/sunxi/clk-sunxi.c                     | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index cba9fe55..291d366 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -51,6 +51,7 @@ Required properties:
>  	"allwinner,sun8i-h3-apb0-gates-clk" - for the APB0 gates on H3
>  	"allwinner,sun9i-a80-apb0-gates-clk" - for the APB0 gates on A80
>  	"allwinner,sun4i-a10-apb1-clk" - for the APB1 clock
> ++	"allwinner,sun8i-a83t-apb1-clk" - for the APB1 clock on A83T

There's one '+' too many

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160317/b1b41ff0/attachment.sig>
