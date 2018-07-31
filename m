From: robh@kernel.org (Rob Herring)
Date: Tue, 31 Jul 2018 14:56:14 -0600
Subject: [PATCH 1/5] dt-binding: dwmac-sun8i: add H6 compatible string
 (w/ A64 fallback)
In-Reply-To: <20180722053955.25266-2-icenowy@aosc.io>
References: <20180722053955.25266-1-icenowy@aosc.io>
 <20180722053955.25266-2-icenowy@aosc.io>
Message-ID: <20180731205614.GA25776@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2018 at 01:39:51PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC features a Ethernet MAC that is similar to the one
> in A64.
> 
> Add a compatible string for it with A64 fallback compatible string, in
> this case the A64 driver can be used.
> 
> The "internal" PHY is not internal from the perspective of the H6 main
> die, instead it's on the co-packaged AC200 chip, and connected to the
> main die with RMII at the in-package Port A PIO bank. So from the SoC
> driver side it needs no special treatment.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
