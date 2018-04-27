From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Apr 2018 15:10:54 -0500
Subject: [PATCH v2 2/6] dt-bindings: clock: mediatek: add g3dsys bindings
In-Reply-To: <665c38d5803573aa9a01471253f406301b1123a1.1524816502.git.sean.wang@mediatek.com>
References: <cover.1524816502.git.sean.wang@mediatek.com>
 <665c38d5803573aa9a01471253f406301b1123a1.1524816502.git.sean.wang@mediatek.com>
Message-ID: <20180427201054.fghwgp4l4yvfs6n6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 04:14:43PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add bindings to g3dsys providing necessary clock and reset control to
> Mali-450.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,g3dsys.txt      | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,g3dsys.txt

Reviewed-by: Rob Herring <robh@kernel.org>
