From: robh@kernel.org (Rob Herring)
Date: Wed, 31 May 2017 11:57:26 -0500
Subject: [PATCH v3 6/9] dmaengine: sun6i: support V3s SoC variant
In-Reply-To: <20170524100607.29790-7-icenowy@aosc.io>
References: <20170524100607.29790-1-icenowy@aosc.io>
 <20170524100607.29790-7-icenowy@aosc.io>
Message-ID: <20170531165726.zmrzawjlnetw2nyd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 06:06:04PM +0800, Icenowy Zheng wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
> 
> Allwinner V3s has a DMA engine similar to the ones from A31, but with
> fewer channels and DRQs.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v3:
> - Added Chen-Yu's ACK.
> 
>  Documentation/devicetree/bindings/dma/sun6i-dma.txt |  1 +
>  drivers/dma/sun6i-dma.c                             | 13 +++++++++++++
>  2 files changed, 14 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
