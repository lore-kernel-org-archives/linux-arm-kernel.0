From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Jun 2017 16:24:03 -0500
Subject: [PATCH v2 1/6] dt-bindings: clock: sunxi-ccu: Add pll-periph to
 PRCM's needed clocks
In-Reply-To: <20170531075824.657-2-wens@csie.org>
References: <20170531075824.657-1-wens@csie.org>
 <20170531075824.657-2-wens@csie.org>
Message-ID: <20170607212403.y4paji7zs4wozbvn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 03:58:19PM +0800, Chen-Yu Tsai wrote:
> The AR100 clock in the PRCM has parents, one of which is pll-periph from
> the main CCU.
> 
> Add it to the list of required clocks for the PRCM CCU.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
