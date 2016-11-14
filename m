From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Nov 2016 09:54:05 +0100
Subject: [PATCH 1/3] ARM: sunxi: add support for H2+ SoC
In-Reply-To: <20161111164654.15273-1-icenowy@aosc.xyz>
References: <20161111164654.15273-1-icenowy@aosc.xyz>
Message-ID: <20161114085405.sa6f6pwvqdiubmkh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Nov 12, 2016 at 12:46:52AM +0800, Icenowy Zheng wrote:
> Allwinner H2+ is a quad-core Cortex-A7 SoC.
> 
> It is very like H3, that they share the same SoC ID (0x1680), and H3
> memory maps as well as drivers works well on the SoC.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  Documentation/arm/sunxi/README                  | 4 ++++
>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>  arch/arm/mach-sunxi/sunxi.c                     | 1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
> index cd02433..1fe4d99c 100644
> --- a/Documentation/arm/sunxi/README
> +++ b/Documentation/arm/sunxi/README
> @@ -63,6 +63,10 @@ SunXi family
>          + User Manual
>            http://dl.linux-sunxi.org/A33/A33%20user%20manual%20release%201.1.pdf
>  
> +      - Allwinner H2+ (sun8i)
> +        + No document available now, but is known to be working properly with
> +          H3 drivers and memory map.
> +
>        - Allwinner H3 (sun8i)
>          + Datasheet
>            http://dl.linux-sunxi.org/H3/Allwinner_H3_Datasheet_V1.0.pdf
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
> index 3975d0a..0c0f277 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.txt
> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> @@ -13,5 +13,6 @@ using one of the following compatible strings:
>    allwinner,sun8i-a33
>    allwinner,sun8i-a83t
>    allwinner,sun8i-h3
> +  allwinner,sun8i-h2plus

That's a nitpick, but I'd prefer to have sun8i-h2-plus.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/085010ba/attachment.sig>
