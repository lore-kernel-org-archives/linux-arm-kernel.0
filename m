From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Apr 2018 15:11:14 -0500
Subject: [PATCH v2 3/6] dt-bindings: clock: mediatek: add entry for
 Mali-450 node to refer
In-Reply-To: <082c3040e2be27d30e0642943f6df35ff4de5666.1524816502.git.sean.wang@mediatek.com>
References: <cover.1524816502.git.sean.wang@mediatek.com>
 <082c3040e2be27d30e0642943f6df35ff4de5666.1524816502.git.sean.wang@mediatek.com>
Message-ID: <20180427201114.wmr2sz2m2took5xz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 04:14:44PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Just add binding for a required clock referenced by Mali-450 on MT7623
> or MT2701 SoC.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  include/dt-bindings/clock/mt2701-clk.h | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
