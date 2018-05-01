From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 11:28:01 -0500
Subject: [PATCH net-next v2 06/15] dt-bindings: net: dwmac-sun8i: Add
 binding for GMAC on Allwinner R40 SoC
In-Reply-To: <20180501161227.2110-7-wens@csie.org>
References: <20180501161227.2110-1-wens@csie.org>
 <20180501161227.2110-7-wens@csie.org>
Message-ID: <20180501162801.GA14124@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 12:12:18AM +0800, Chen-Yu Tsai wrote:
> The Allwinner R40 SoC has the EMAC controller supported by dwmac-sun8i.
> It is named "GMAC", while EMAC refers to the 10/100 Mbps Ethernet
> controller supported by sun4i-emac. The controller is the same, but
> the R40 has the glue layer controls in the clock control unit (CCU),
> with a reduced RX delay chain, and no TX delay chain.
> 
> This patch adds the R40 specific bits to the dwmac-sun8i binding.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
