From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 11:26:15 -0500
Subject: [PATCH net-next v2 03/15] dt-bindings: net: dwmac-sun8i: Clean
 up clock delay chain descriptions
In-Reply-To: <20180501161227.2110-4-wens@csie.org>
References: <20180501161227.2110-1-wens@csie.org>
 <20180501161227.2110-4-wens@csie.org>
Message-ID: <20180501162615.GA11761@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 12:12:15AM +0800, Chen-Yu Tsai wrote:
> The clock delay chains found in the glue layer for dwmac-sun8i are only
> used with RGMII PHYs. They are not intended for non-RGMII PHYs, such as
> MII external PHYs or the internal PHY. Also, a recent SoC has a smaller
> range of possible values for the delay chain.
> 
> This patch reformats the delay chain section of the device tree binding
> to make it clear that the delay chains only apply to RGMII PHYs, and
> make it easier to add the R40-specific bits later.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
