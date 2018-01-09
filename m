From: robh@kernel.org (Rob Herring)
Date: Mon, 8 Jan 2018 21:34:02 -0600
Subject: [PATCH 01/12] dt-bindings: clock: mediatek: add missing required
 #reset-cells
In-Reply-To: <084288e2520f9bd3ccdb3cf7aeef8ebcae48e6d7.1515057696.git.sean.wang@mediatek.com>
References: <cover.1515057696.git.sean.wang@mediatek.com>
 <084288e2520f9bd3ccdb3cf7aeef8ebcae48e6d7.1515057696.git.sean.wang@mediatek.com>
Message-ID: <20180109033402.bxk6ukd5zyzemnya@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 05:40:51PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> All ethsys, pciesys and ssusbsys internally include reset controller, so
> explicitly add back these missing cell definitions to related bindings
> and examples.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt   | 2 ++
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt  | 2 ++
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt | 2 ++
>  3 files changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
