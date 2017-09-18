From: robh@kernel.org (Rob Herring)
Date: Mon, 18 Sep 2017 16:08:36 -0500
Subject: [PATCH 1/4] dt-bindings: simplefb-sunxi: add pipelines for DE2
In-Reply-To: <20170911155529.62891-2-icenowy@aosc.io>
References: <20170911155529.62891-1-icenowy@aosc.io>
 <20170911155529.62891-2-icenowy@aosc.io>
Message-ID: <20170918210836.47rfbykii2tp5pxt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 11, 2017 at 11:55:26PM +0800, Icenowy Zheng wrote:
> As we're going to add simplefb support for Allwinner SoCs with DE2, add
> suitable pipeline strings in the device tree binding.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/display/simple-framebuffer-sunxi.txt          | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
