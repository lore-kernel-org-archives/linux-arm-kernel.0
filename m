From: robh@kernel.org (Rob Herring)
Date: Sun, 16 Sep 2018 22:05:28 -0500
Subject: [PATCH 01/27] dt-bindings: sunxi-sram: add binding for Allwinner
 H6  SRAM C
In-Reply-To: <20180902072643.4917-2-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-2-jernej.skrabec@siol.net>
Message-ID: <5b9f3f79.1c69fb81.21dc2.1e01@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  2 Sep 2018 09:26:17 +0200, Jernej Skrabec wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> The Allwinner H6 SoC's DE3 needs the SRAM C section being claimed in the
> system controller to work, like A64 DE2.
> 
> As H6 and A64 system controller are quite similar, code is reused now,
> and the A64 fallback compatible string is added after the H6 compatible
> string.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> [fixed typo in compatible string]
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
