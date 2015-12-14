From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Dec 2015 09:36:28 +0800
Subject: [PATCH V2 1/2] devicetree: bindings: Add vendor prefix for Kosagi
In-Reply-To: <1448722024-5717-1-git-send-email-marex@denx.de>
References: <1448722024-5717-1-git-send-email-marex@denx.de>
Message-ID: <20151214013628.GO11252@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2015 at 03:47:03PM +0100, Marek Vasut wrote:
> From: Sean Cross <xobs@kosagi.com>
> 
> Add a vendor prefix for Sutajio Ko-Usagi PTE Ltd., which goes by the
> more common name of Kosagi.
> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Rob Herring <robh@kernel.org>

Hi Rob,

Are you okay with this patch?

Shawn

> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> V2: Add my SoB line.
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 62ff22f..d3ee06e 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -124,6 +124,7 @@ jedec	JEDEC Solid State Technology Association
>  karo	Ka-Ro electronics GmbH
>  keymile	Keymile GmbH
>  kinetic Kinetic Technologies
> +kosagi	Sutajio Ko-Usagi PTE Ltd.
>  lacie	LaCie
>  lantiq	Lantiq Semiconductor
>  lenovo	Lenovo Group Ltd.
> -- 
> 2.1.4
> 
> 
